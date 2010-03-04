require 'rexml/document'

module Ant2Rake

  class << self

    def element_type(name, &proc)
      Elements[name] = Element.new name, proc
    end
 
    def ant2rake(element)

      @depth = @depth || 0
      @depth += 1

      out = out || ''
      if Elements[element.name]
        out << Elements[element.name].process(element)
      end

      #      element.each_element do |ele|
      #        p "#{@depth} #{ele.name}"
      #        ant2rake ele
      #      end

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
        "\"#{self}\""
      end
    end

    def to_identifier
      def to_identifier
        "#{self.gsub(/\.|\s|-|\/|\'/, '_').downcase}".to_sym
      end
    end

  end

  # add ant2rake method to element class
  REXML::Element.class_eval do
    define_method :ant2rake do
      out = ''
      self.each_element do |ele|
        out << Ant2Rake::ant2rake(ele)
      end
      return out
    end
  end

end

require 'ant2rake/definitions'