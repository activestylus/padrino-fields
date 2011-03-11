require 'padrino-helpers'

require File.expand_path(File.dirname(__FILE__) + '/orms/datamapper')
require File.expand_path(File.dirname(__FILE__) + '/settings')

module Padrino
  module Helpers
    module FormBuilder #:nodoc:
      class FieldsFormBuilder < AbstractFormBuilder #:nodoc:
        
        include Padrino::Helpers::FormBuilder::Orm::Datamapper
        include Padrino::Fields::Settings
        @@settings = Padrino::Fields::Settings
        
        attr_reader :template, :object_name, :object
        
        def klazz
          @object.class
        end
        
        def input(attribute, options={}, label_options={})
          label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
          type = klazz.form_column_type_for(attribute)
          field_html = setup_label(attribute,type,options)
          field_html << default_input(attribute, options)
          field_html << hint_tag(options[:hint]) if options[:hint]
          field_html << @template.error_message_on(@object,attribute,{})
          @template.content_tag(@@settings.container, :class => css_class(attribute,type)) do
            field_html
          end
        end
        
        def default_input(attribute, options={})
          type = options[:as] ? options[:as] : klazz.form_column_type_for(attribute)
          as = nil || options[:as]
          input_options = options.keep_if {|key, value| key != :as}
          if options[:options].nil?
            singular_input_for(type,attribute,options)
          elsif as==:radios
            collect_inputs_as(:radios,attribute,input_options)
          elsif as==:checks
            collect_inputs_as(:checks,attribute,input_options)
          elsif as.nil?
            select(attribute,input_options)
          end
        end
        
        protected
        
        def collect_inputs_as(type,attribute,options={})
          options[:options].map do |item|
            collection_input(type, attribute, item, options.keep_if {|key, value| key != :options})
          end.join("")
        end
        
        def singular_input_for(type,attribute,options={})
          klass = type.to_s
          klass << ' required' if required?(attribute)
          case type
          when :text
            text_area(attribute, options.merge(:class => klass))
          when :boolean
            check_box(attribute, options.merge(:class => klass))
          else
            text_field(attribute, options.merge(:class => klass))
          end
        end
        
        def required?(attribute)
          k = klazz.is_a?(String) ? klazz.constantize : klazz
          k.form_attribute_is_required?(attribute)
        end
        
        def collection_input(type, attribute, item, options={})
          unchecked_value = options.delete(:uncheck_value) || '0'
          options.reverse_merge!(:id => field_id(attribute), :value => '1')
          options.reverse_merge!(:checked => true) if values_matches_field?(attribute, options[:value])
          name =  type == :checks ? field_name(attribute) + '[]' : field_name(attribute)
          ite  =  item.downcase.gsub(' ','_').gsub(/[^[:alnum:]]/, '')
          id   =  field_id(attribute) + "_#{ite}"
          klass = css_class(attribute,type)
          if type == :checks
            html =  @template.hidden_field_tag(options[:name] || name, :value => unchecked_value, :id => nil)
            input_item = @template.check_box_tag(name, options.merge(:id => id, :class => klass))
          else
            html = ""
            input_item = @template.radio_button_tag(name, options.merge(:id => id, :class => klass))
          end
          html << "<label for='#{id}' class='#{klass}'>#{input_item}#{item}</label>"
        end
        
        def setup_label(attribute, type, options={})
          marker = @@settings.label_required_marker
          text = ""
          text << marker if required?(attribute) && @@settings.label_required_marker_position == :prepend
          text << field_human_name(attribute)
          text << marker if required?(attribute) && @@settings.label_required_marker_position == :append
          options.reverse_merge!(:caption => text, :class => css_class(attribute,type))
          @template.label_tag(field_id(attribute), options)
        end
        
        def css_class(attribute,type)
          klass = type.to_s
          klass << ' required' if required?(attribute)
          klass
        end
        
        def hint_tag(text)
          @template.content_tag(:span, :class=>'hint') { text }
        end
                
      end # StandardFormBuilder
    end # FormBuilder
  end # Helpers
end # Padrino