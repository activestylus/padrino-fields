require 'dm-core'
require 'dm-validations'

module PadrinoFields
  module DataMapperWrapper
    module ClassMethods

      attr_reader :reflection
      
      def form_attribute_validators; validators.contexts[:default]; end
      
      def form_validators_on(attribute)
        validators.contexts[:default].find_all {|v| v.field_name == attribute}
      end
      
      def form_attribute_is_required?(attribute)
        form_validators_on(attribute).find_all {|v| v.class == DataMapper::Validations::PresenceValidator }.any?
      end
      
      def form_reflection_validators(reflection=nil)
        new.send(reflection).validators.contexts[:default]
      end
      
      def form_has_required_attributes?(reflection=nil)
        validators = form_attribute_validators
        validators += reflection_validators(reflection) if reflection
        validators.find_all {|v| v.class == DataMapper::Validations::PresenceValidator }.any?
      end
      
      def form_column_type_for(attribute)
        klass = properties.find_all {|p| p.name == attribute}.first.class      
        if klass == DataMapper::Property::String
          :string
        elsif klass == DataMapper::Property::Text
          :text
        elsif [DataMapper::Property::Integer,DataMapper::Property::Decimal,DataMapper::Property::Float].include?(klass)
          :number
        elsif klass == DataMapper::Property::Boolean
          :boolean
        elsif [DataMapper::Property::Date,DataMapper::Property::DateTime].include?(klass)
          :date
        elsif klass == DataMapper::Property::Serial
          :serial
        else
          nil
        end
      end
      
    end # ClassMethods
  end # Datamapper
end # PadrinoFields

DataMapper::Model.append_extensions(PadrinoFields::DataMapperWrapper::ClassMethods)
#DataMapper::Model.append_inclusions(PadrinoFields::DataMapperWrapper::InstanceMethods) 