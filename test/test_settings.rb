require "helper"

class TestPadrinoFieldsSettings < ActiveSupport::TestCase
  
  should "make setup block yield self" do
    Padrino::Fields::Settings.setup do |config|
      assert_equal Padrino::Fields::Settings, config
    end
  end
  
  context "for #container setting" do
    should "wrap field in a custom container" do
      Padrino::Fields::Settings.container = :div
      actual = field.input(:name)
      assert_has_tag("div") { actual }
    end
  end
  
  context "for #label_required_marker setting" do
    should "display custom label marker for a required field" do
      Padrino::Fields::Settings.label_required_marker = "*"
      actual = field.setup_label(:name, 'string')
      assert_has_tag("label", :content => "*Name") { actual }
    end
  end
  
  context "for #label_required_marker_position setting" do
    should "prepend label marker to a required field" do
      Padrino::Fields::Settings.label_required_marker_position = :prepend
      actual = field.setup_label(:name, 'string')
      assert_has_tag("label", :content => "*Name") { actual }
    end
    should "append label marker to a required field" do
      Padrino::Fields::Settings.label_required_marker_position = :append
      actual = field.setup_label(:name, 'string')
      assert_has_tag("label", :content => "Name*") { actual }
    end
  end
  
end
