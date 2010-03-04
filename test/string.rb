$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'ant2rake'

module Ant2Rake
  
  class StringMethods < Test::Unit::TestCase
    
    def test_runtime_props_method

      assert_equal "\"some value\"", 'some value'.resolve_properties
      assert_equal "@properties['some.value']", '${some.value}'.resolve_properties
      assert_equal '"#{@properties[\'some.value\']}/some/more"', '${a.value}/some/more'.resolve_properties
      assert_equal '"/before/value/#{@properties[\'some.value\']}"', '/before/value/${the.value}'.resolve_properties

    end

  end

end
