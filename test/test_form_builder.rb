require "helper"

class TestFormBuilder < Test::Unit::TestCase
  
  def setup
    @invalid_person = mock_model(Person, :name => nil)
    @invalid_person.stubs(:errors => {:name => "must be present"})
    @person = mock_model(Person, :name => "Joe")
    @person_none = mock_model(Person)
  end
  
  context "for #input method" do
    
    should "wrap field elements in a <p> tag by default" do
      actual = field.input(:string)
      assert_has_tag("p", :class => "string") { actual }
    end
    
    should "wrap field elements in a specified tag" do
      Padrino::Fields::Settings.setup do |config|
        config.container = :div
      end
      actual = field.input(:name)
      assert_has_tag("div") { actual }
    end
    
    should "mark container and labels if attribute is required" do
      actual = field.input(:name)
      assert_has_tag("p", :class => "string required") { actual }
    end
    
    should "display error messages on a field with an error" do
      actual = field(@invalid_person).input(:name)
      assert_has_tag("span", :class=>"error", content:"must be present") { actual }
    end
    
    should "display a hint when specified" do
      actual = field.input(:name, :hint => "person's full name")
      assert_has_tag("span", :class=>"hint", content:"person's full name") { actual }
    end
    
  end
  
  context "for #default_input method" do

    should "return default input matching the attribute's column type" do
      text = field.default_input(:text)
      assert_has_tag("textarea", id:"person_text", name:"person[text]", :class => "text") { text }
      string = field.default_input(:string)
      assert_has_tag("input[type=text]", id:"person_string", name:"person[string]", :class => "string") { string }
      date = field.default_input(:date)
      assert_has_tag("input[type=text]", id:"person_date", name:"person[date]", :class => "date") { date }
      boolean = field.default_input(:boolean)
      assert_has_tag("input", type:"checkbox", id:"person_boolean", name:"person[boolean]", :class => "boolean") { boolean }
    end

    should "return a specified input type via :as key" do
      actual = field.default_input(:name, :as => :string)
      assert_has_tag("input", type:"text", id:"person_name", name:"person[name]") { actual }
    end

    should "return a select field if :options are specified" do
      actual = field.default_input(:name, :options => ["Ann","Bob"])
      assert_has_tag("select", id:"person_name", name:"person[name]") { actual }
      assert_has_tag("select option", value:"Ann", content:"Ann") { actual }
    end

    should "return a collection of checkboxes if :options and :as=>:checks are specified" do
      actual = field.default_input(:string, :options => ["Ann","Bob"], :as => :checks)
      assert_has_tag("label", :class => "checks", :for => "person_string_ann", content:"Ann") { actual }
      assert_has_tag("label input", type:"checkbox", value:"1", id:"person_string_ann", name:"person[string][]") { actual }
      assert_has_tag("input", type:"hidden", name:"person[string][]", value:"0") { actual }
      assert_has_tag("label", :class => "checks", :for => "person_string_bob", content:"Bob") { actual }
      assert_has_tag("label input", type:"checkbox", value:"1", id:"person_string_bob", name:"person[string][]") { actual }
      assert_has_tag("input", type:"hidden", name:"person[string][]", value:"0") { actual }
    end

    should "return a collection of radio buttons if :options and :as=>:radio are specified" do
      actual = field.default_input(:string, :options => ["Ann","Bob"], :as => :radios)
      assert_has_tag("label", :class => "radios", :for => "person_string_ann", content:"Ann") { actual }
      assert_has_tag("input", type:"radio", id:"person_string_ann", name:"person[string]") { actual }
      assert_has_tag("label", :class => "radios", :for => "person_string_bob", content:"Bob") { actual }
      assert_has_tag("input", type:"radio", id:"person_string_bob", name:"person[string]") { actual }
    end

    should "add a css class marking a required input" do
      actual = field.default_input(:name)
      assert_has_tag("input", :class => "string required") { actual }
    end
    
  end
  
  context "for #setup_label method" do
    
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
  
  context "for #hint_tag method" do
    should "display text in a hint span" do
      actual = field.hint_tag('Here is a hint')
      assert_has_tag("span", :class => "hint", content:"Here is a hint") { actual }
    end
  end
  
end