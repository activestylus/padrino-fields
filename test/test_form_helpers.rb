require "helper"

class TestFormHelper < ActiveSupport::TestCase

    %w(date email number search tel url).each do |type|
      class_eval <<-EOF
      context 'for ##{type}_field_tag method' do
        should "return a #{type} field" do
          actual = #{type}_field_tag('#{type}')
          assert_has_tag('input', type:'#{type}', name:'#{type}') { actual }
        end
      end
      EOF
    end
  
end