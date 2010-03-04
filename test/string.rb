$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'ant2rake'

module Ant2Rake
  
  class StringMethods < Test::Unit::TestCase
    
    def test_runtime_props_method

      assert_equal "\"some value\"", 'some value'.resolve_properties
      assert_equal "@properties['some.value']", '${some.value}'.resolve_properties
      assert_equal '"#{@properties[\'a.value\']}/some/more"', '${a.value}/some/more'.resolve_properties
      assert_equal '"/before/value/#{@properties[\'the.value\']}"', '/before/value/${the.value}'.resolve_properties

    end

    def test_to_identifier_method

      assert_equal :some_string, "some string".to_identifier
      assert_equal :another_string, "another.string".to_identifier
      assert_equal :a_dashed_string, "a-dashed-string".to_identifier
      
    end

  end

end
