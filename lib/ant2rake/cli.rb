require 'rexml/document'

module Ant2Rake
  module Cli
    class Runner

      def initialize(input_file,output_file)

        file = File.new(input_file)
        @doc = REXML::Document.new file
        
        @output = File.new(output_file,'w')

      end

      def go
        @output << Ant2Rake::ant2rake(@doc.root)
      end

    end
  end
end