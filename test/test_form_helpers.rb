require "helper"

class TestFormHelper < Test::Unit::TestCase
  
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
    
    context '#select_tag' do
      should "return a select tag with grouped options for an nested array" do
        opts = [
          ["Friends",["Yoda",["Obiwan",2]]],
          ["Enemies", ["Palpatine",['Darth Vader',3]]]
        ]
        actual = select_tag( 'name', :grouped_options => opts )
        assert_has_tag("select", name:"name") { actual }
        assert_has_tag("optgroup", label:"Friends") { actual }
        assert_has_tag("option", value:"Yoda", content:"Yoda") { actual }
        assert_has_tag("option", value:"2", content:"Obiwan") { actual }
        assert_has_tag("optgroup", label:"Enemies") { actual }
        assert_has_tag("option", value:"Palpatine", content:"Palpatine") { actual }
        assert_has_tag("option", value:"3", content:"Darth Vader") { actual }
      end
      
      should "return a select tag with grouped options for a hash" do
        opts = {
          "Friends" => ["Yoda",["Obiwan",2]],
          "Enemies" => ["Palpatine",['Darth Vader',3]]
        }
        actual = select_tag( 'name', :grouped_options => opts )
        assert_has_tag("select", name:"name") { actual }
        assert_has_tag("optgroup", label:"Friends") { actual }
        assert_has_tag("option", value:"Yoda", content:"Yoda") { actual }
        assert_has_tag("option", value:"2", content:"Obiwan") { actual }
        assert_has_tag("optgroup", label:"Enemies") { actual }
        assert_has_tag("option", value:"Palpatine", content:"Palpatine") { actual }
        assert_has_tag("option", value:"3", content:"Darth Vader") { actual }
      end
    end
  
end