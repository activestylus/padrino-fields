require "helper"

class TestFormBuilder < Test::Unit::TestCase
  
  def setup
    @invalid_person = mock_model(Person, :name => nil)
    @invalid_person.stubs(:errors => {:name => "must be present"})
    @person = mock_model(Person, :name => "Joe")
    @person_none = mock_model(Person)
  end
  
  context "#input" do
    
    should "wrap field elements in a <p> tag by default" do
      actual = field.input(:string)
      assert_has_tag("p", :class => "string") { actual }
    end
    
    should "mark container and labels as required" do
      actual = field.input(:name)
      assert_has_tag("p", :class => "string required") { actual }
    end
    
    should "display error messages" do
      actual = field(@invalid_person).input(:name)
      assert_has_tag("span", :class=>"error", content:"must be present") { actual }
    end
    
    should "display a hint" do
      actual = field.input(:name, :hint => "person's full name")
      assert_has_tag("span", :class=>"hint", content:"person's full name") { actual }
    end
    
    should "customize input's html" do
      actual = field.input(:name, :input_html => {:class => 'nice', :size => 8})
      assert_has_tag("input", :class=>"nice", :size => '8') { actual }
    end
    
    should "return boolean field" do
      actual = field.input(:name, :as => :boolean)
      assert_has_tag("input", type:"checkbox") { actual }
      assert_has_tag("label", content:"Name") { actual }
    end
    
    should "disable the input" do
      actual = field.input(:name, :disabled => :true)
      assert_has_tag("input", disabled:"disabled") { actual }
    end
    
    should "show custom label text" do
      actual = field.input(:string, :caption => "Cool!")
      assert_has_tag("label", content:"Cool!") { actual }
    end
    
    should "show no label text" do
      actual = field.input(:string, :caption => false)
      assert_has_tag("label", content:nil) { actual }
    end
    
    %w(email search tel url).each do |type|
      instance_eval <<-EOF
      should "return #{type} field for #{type} attribute" do
        actual = field.input(:#{type})
        assert_has_tag("input", type:"#{type}") { actual }
      end
      EOF
    end
    
    should "return tel field for phone attribute" do
      actual = field.input(:phone)
      assert_has_tag("input", type:"tel") { actual }
    end
    
    should "return url field for website attribute" do
      actual = field.input(:website)
      assert_has_tag("input", type:"url") { actual }
    end
    

    should "return default input matching the attribute's column type" do
      text = field.input(:text)
      assert_has_tag("textarea", id:"person_text", name:"person[text]", :class => "text") { text }
      string = field.input(:string)
      assert_has_tag("input[type=text]", id:"person_string", name:"person[string]", :class => "string") { string }
      date = field.input(:date)
      assert_has_tag("input", type:'date', id:"person_date", name:"person[date]", :class => "date") { date }
      boolean = field.input(:boolean)
      assert_has_tag("input", type:"checkbox", id:"person_boolean", name:"person[boolean]", :class => "boolean") { boolean }
    end

    should "return a specified input type" do
      actual = field.input(:name)
      assert_has_tag("input", type:"text", id:"person_name", name:"person[name]") { actual }
    end

    # should "return a select field" do
    #   actual = field.input(:name, :options => [["Ann",1],["Bob",2]])
    #   assert_has_tag("select", id:"person_name", name:"person[name]") { actual }
    #   assert_has_tag("option", value:"1", content:"Ann") { actual }
    #   assert_has_tag("option", value:"2", content:"Bob") { actual }
    # end
    
    should "return a select tag with options" do
      actual = field.input(:name, :options => ["Ann",["Bob",2]])
      assert_has_tag("select", id:"person_name", name:"person[name]") { actual }
      assert_has_tag("option", value:"Ann", content:"Ann") { actual }
      assert_has_tag("option", value:"2", content:"Bob") { actual }
    end

    should "return a collection of checkboxes" do
      actual = field.input(:string, :options => ["Ann","Bob"], :as => :checks)
      assert_has_tag("label", :class => "checks", :for => "person_string_ann", content:"Ann") { actual }
      assert_has_tag("input", type:"checkbox", value:"Ann", id:"person_string_ann", name:"person[string][]") { actual }
      assert_has_tag("input", type:"hidden", name:"person[string][]", value:"0") { actual }
      assert_has_tag("label", :class => "checks", :for => "person_string_bob", content:"Bob") { actual }
      assert_has_tag("input", type:"checkbox", value:"Bob", id:"person_string_bob", name:"person[string][]") { actual }
      assert_has_tag("input", type:"hidden", name:"person[string][]", value:"0") { actual }
    end
    
    should "return a collection of checkboxes using a multi-dimensional array" do
      actual = field.input(:string, :options => [["Ann",1],["Bob",2]], :as => :checks)
      assert_has_tag("label", :class => "checks", :for => "person_string_ann", content:"Ann") { actual }
      assert_has_tag("input", type:"checkbox", value:"1", id:"person_string_ann", name:"person[string][]") { actual }
      assert_has_tag("input", type:"hidden", name:"person[string][]", value:"0") { actual }
      assert_has_tag("label", :class => "checks", :for => "person_string_bob", content:"Bob") { actual }
      assert_has_tag("input", type:"checkbox", value:"2", id:"person_string_bob", name:"person[string][]") { actual }
      assert_has_tag("input", type:"hidden", name:"person[string][]", value:"0") { actual }
    end

    should "return a collection of radio buttons" do
      actual = field.input(:string, :options => ["Ann","Bob"], :as => :radios)
      assert_has_tag("label", :class => "radios", :for => "person_string_ann", content:"Ann") { actual }
      assert_has_tag("input", type:"radio", id:"person_string_ann", name:"person[string]", value:"Ann") { actual }
      assert_has_tag("label", :class => "radios", :for => "person_string_bob", content:"Bob") { actual }
      assert_has_tag("input", type:"radio", id:"person_string_bob", name:"person[string]", value:"Bob") { actual }
    end
    
    should "return a collection of radio buttons using a multi-dimensional array" do
      actual = field.input(:string, :options => [["Ann",1],["Bob",2]], :as => :radios)
      assert_has_tag("label", :class => "radios", :for => "person_string_ann", content:"Ann") { actual }
      assert_has_tag("input", type:"radio", id:"person_string_ann", name:"person[string]", value:"1") { actual }
      assert_has_tag("label", :class => "radios", :for => "person_string_bob", content:"Bob") { actual }
      assert_has_tag("input", type:"radio", id:"person_string_bob", name:"person[string]", value:"2") { actual }
    end

    should "add a css class marking a required input" do
      actual = field.input(:name)
      assert_has_tag("input", :class => "string required") { actual }
    end
    
    should "render a file field" do
      actual = field.input(:string, :as => :file)
      assert_has_tag("input", :type => "file") { actual }
    end
  end
  
  context "#setup_label" do
    
    should "display default field marker for a required label" do
      actual = field.setup_label(:name, "string")
      expected = "<label class=\"string required\" for=\"person_name\"><abbr>*</abbr>Name</label>"
      assert_equal expected, actual
    end
    
    should "not display field marker for an optional field" do
      actual = field.setup_label(:string, 'string')
      expected = "<label class=\"string\" for=\"person_string\">String</label>"
      assert_equal expected, actual
    end
    
  end
  
  context "#hint" do
    should "display text in a hint span" do
      actual = field.hint('Here is a hint')
      assert_has_tag("span", :class => "hint", content:"Here is a hint") { actual }
    end
  end
  
  context '#domize' do
    should "convert text to a dom-friendly string" do
      assert_equal "cool", field.domize('C!@#$o%^&*o(_)l+{[<>]},./\|')
    end
  end
  
end