require 'rexml/document'

module Ant2Rake

  class << self

    def ant_element(name, &proc)
      Elements[name] = Element.new name, proc
    end
 
    def ant2rake(element)

      @depth = @depth || -1
      @depth += 1

      out = ''
      if Elements[element.name]
        ruby_code_for_element = Elements[element.name].process(element)
        if !ruby_code_for_element
          print "Error creating ruby code for #{element.name} (returned #{ruby_code_for_element})\n"
          ruby_code_for_element = "\n=begin\n#{element}\n=end\n"
        end
        out << ruby_code_for_element
      else
        # print undefined elements in comments
        # out << "\n=begin\n#{element}\n=end\n"
        out << Elements['default'].process(element)
      end

      @depth -= 1
      return out
    end

  end

  class Elements
    def self.[]= (name, form)
      @elements ||= {}
      @elements[name] = form
    end

    def self.[](name)
      @elements ||= {}
      @elements[name]
    end
  end

  class Element

    def initialize(name, proc)
      @name = name
      @proc = proc
    end

    def process(element)
      element.instance_eval(&@proc)
    end
    
  end

  class ::String

    # convert string containing properties
    # examples:
    # "${some.prop}" returns @properties['some.prop']
    # "${some.prop}/some/more" returns "#{@properties['some.prop']}/some/more"
    def resolve_properties
      if(m = (/^\$\{([\S]+)\}$/.match(self)))
        "@properties['#{m[1]}']"
      else
        replaced = self.gsub(/\$\{([A-Za-z\.\-_]+)\}/,'#{@properties[\'\1\']}')
        "\"#{replaced}\""
      end
    end

    def to_identifier
      "#{self.gsub(/\.|\s|-|\/|\'/, '_').downcase}".to_sym
    end

  end

  # add ant2rake method to element class
  REXML::Element.class_eval do
    def ant2rake(element=false)
      out = ''
      if element
        out << Ant2Rake::ant2rake(element)
      else
        self.each_element do |ele|
          out << Ant2Rake::ant2rake(ele)
        end
      end
      return out
    end
  end

end

require 'ant2rake/definitions'