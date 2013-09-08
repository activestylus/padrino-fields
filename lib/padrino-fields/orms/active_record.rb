require 'active_record'

module PadrinoFields
  module ActiveRecordWrapper
    module ClassMethods
      def form_attribute_is_required?(attribute)
        if respond_to?(:reflect_on_validations_for)
          reflect_on_validations_for(attribute).any? { |v| v.macro == :validates_presence_of }
        else
          false
        end
      end

      def form_column_type_for(attribute)
        if column_reflection = columns_hash[attribute.to_s]
          column_type = column_reflection.type

          case column_type
          when :integer, :float, :decimal
            :number
          when :date, :time, :datetime, :timestamp
            :date
          when :primary_key
            :serial
          else
            column_type
          end
        else
          :string
        end
      end
    end # ClassMethods
  end # ActiveRecord
end # PadrinoFields

ActiveRecord::Base.send :extend, PadrinoFields::ActiveRecordWrapper::ClassMethods
