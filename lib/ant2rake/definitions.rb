module Ant2Rake

  element_type 'project' do
    "@project_name='#{self.attributes['name']}'" if self.attributes['name']
    ant2rake
  end

  element_type 'property' do

      if self.attributes['environment']
        "@environment = \"#{}\""
      else
        value = self.attributes['value'] || self.attributes['location']
        "@properties['#{self.attributes['name']}'] = #{value.resolve_properties}"
      end

  end


end