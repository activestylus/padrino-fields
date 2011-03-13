require 'helper'

class TestDataMapper < Test::Unit::TestCase

  include PadrinoFields
  include PadrinoFields::DataMapperWrapper
  
  context "for #form_attribute_is_required? method" do
    
    should "return true if attribute is required" do
      assert Person.form_attribute_is_required?(:name)
    end
    should "return false if attribute is not required" do
      assert_equal false, Person.form_attribute_is_required?(:string)
    end
    
  end
  
  context "for #form_has_required_attributes? method" do
    
    should "return true if any attributes are required" do
      assert Person.form_has_required_attributes?
    end
    should "return false if no attributes are required" do
      assert_equal false, Nobody.form_has_required_attributes?
    end
    
  end
    
  context "for #form_reflection_validators method" do
    
    should "return validations for an associated model" do
      expected = [
        DataMapper::Validations::NumericalityValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::NumericalityValidator
      ]
      assert_equal expected, Person.form_reflection_validators(:nobodies).map(&:class)
    end
    
  end
  
  context "for #form_attribute_validators method" do
    
    should "return validations for a model" do
      expected = [
        DataMapper::Validations::NumericalityValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::NumericalityValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::NumericalityValidator,
        DataMapper::Validations::NumericalityValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::LengthValidator,
        DataMapper::Validations::PrimitiveTypeValidator,
        DataMapper::Validations::PresenceValidator
      ]
      assert_equal expected, Person.form_attribute_validators.map(&:class)
    end
    
  end
  
  context 'for #form_column_type_for method' do
  
    should "return :string for String columns" do
      assert_equal :string, Person.form_column_type_for(:name)
    end            
    should "return :text for Text columns" do
      assert_equal :text, Person.form_column_type_for(:text)
    end
    should "return :number for Decimal columns" do
      assert_equal :number, Person.form_column_type_for(:decimal)
    end            
    should "return :number for Float columns" do
      assert_equal :number, Person.form_column_type_for(:float)
    end            
    should "return :number for Integer columns" do
      assert_equal :number, Person.form_column_type_for(:integer)
    end            
    should "return :date for Date columns" do
      assert_equal :date, Person.form_column_type_for(:date)
    end            
    should "return :date for DateTime columns" do
      assert_equal :date, Person.form_column_type_for(:datetime)
    end            
    should "return :boolean for Boolean columns" do
      assert_equal :boolean, Person.form_column_type_for(:boolean)
    end
 
  end

end