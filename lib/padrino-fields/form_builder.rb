require 'padrino-helpers'
require File.expand_path(File.dirname(__FILE__) + '/form_helpers')
require File.expand_path(File.dirname(__FILE__) + '/orms/datamapper') if defined?(DataMapper)
require File.expand_path(File.dirname(__FILE__) + '/settings')

module Padrino
  module Helpers
    module FormBuilder #:nodoc:
      class PadrinoFieldsBuilder < AbstractFormBuilder #:nodoc:
        
        include PadrinoFields::Settings
        include PadrinoFields::DataMapperWrapper if defined?(DataMapper)
        
        @@settings = PadrinoFields::Settings
        
        attr_reader :template, :object_name, :object
        
        def input(attribute, options={})
          options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
          type = options[:as] || klazz.form_column_type_for(attribute)
          field_html =  ""
          if type == :boolean || options[:as] == :boolean
            field_html << default_input(attribute,type,options) 
            field_html << setup_label(attribute,type,labelize(options))
          else
            field_html << setup_label(attribute,type,labelize(options))
            field_html << default_input(attribute,type, options)
          end
          field_html << hint(options[:hint]) if options[:hint]
          field_html << @template.error_message_on(@object,attribute,{}) if @object.errors.any?
          @template.content_tag(@@settings.container, :class => css_class(attribute,type,options[:disabled])) do
            field_html
          end
        end
        
        def default_input(attribute,type,options={})
          input_options = options.keep_if {|key, value| key != :as}
          if options[:options].nil?
            singular_input_for(attribute,type,options)
          elsif type==:radios
            collect_inputs_as(attribute,:radios,input_options)
          elsif type==:checks
            collect_inputs_as(attribute,:checks,input_options)
          else
            select(attribute,input_options)
          end
        end
        
        %w(date email number search tel url).each do |type|
          class_eval <<-EOF
          ##
          # Constructs a #{type} field input from the given options
          #
          # ==== Examples
          #
          #   #{type}_field :username, :class => 'long'
          #
          def #{type}_field(field, options={})
            options.reverse_merge!(:value => field_value(field), :id => field_id(field))
            options.merge!(:class => field_error(field, options))
            @template.#{type}_field_tag(field_name(field), options)
          end
          EOF
        end
        

        def collect_inputs_as(attribute,type,options={})
          options[:options].map do |item|
            collection_input(attribute,type,item,options.keep_if {|key, value| key != :options})
          end.join("")
        end
        
        def singular_input_for(attribute,type,options={})
          options.keep_if {|key, value| key != :for}
          opts = html_options(attribute,type,options)
          case type
          when :string
            case attribute
            when /email/         ; email_field(attribute, opts);
            when /password/      ; password_field(attribute, opts);
            when /tel/,/phone/   ; tel_field(attribute, opts);
            when /url/,/website/ ; url_field(attribute, opts);
            when /search/        ; search_field(attribute, opts);
            else                 ; text_field(attribute, opts);
            end
          when :text
            text_area(attribute, opts)
          when :boolean
            check_box(attribute, opts)
          when :date
            date_field(attribute, opts)
          when :file
            file_field(attribute, opts)
          when :number
            number_field(attribute, opts)
          when :radios
            default_radios(attribute,type,options)
          end
        end
        
        def required?(attribute)
          k = klazz.is_a?(String) ? klazz.constantize : klazz
          k.form_attribute_is_required?(attribute)
        end
        
        def collection_input(attribute,type,item, options={})
          unchecked_value = options.delete(:uncheck_value) || '0'
          options.reverse_merge!(:id => field_id(attribute), :value => '1')
          options.reverse_merge!(:checked => true) if values_matches_field?(attribute, options[:value])
          klass =  css_class(attribute,type,options[:disabled])
          name  =  type == :checks ? field_name(attribute) + '[]' : field_name(attribute)
          if item.is_a?(Array)
            text, value = item[0], item[1]
          else
            text = item; value = item;
          end
          id = field_id(attribute) + "_" + domize(text)
          opts = html_options(attribute,type,options.merge(:id => id, :class => klass, :value => value))
          if type == :checks
            html = @template.hidden_field_tag(options[:name] || name, :value => unchecked_value, :id => nil)
            input_item = @template.check_box_tag(name, opts)
          else
            html = ""
            input_item = @template.radio_button_tag(name, opts)
          end
          html << "<label for='#{id}' class='#{klass}'>#{input_item}#{text}</label>"
        end
        
        def domize(text)
          text.downcase.gsub(' ','_').gsub(/[^[:alnum:]]/, '')
        end
        
        def setup_label(attribute, type, options={})
          marker = @@settings.label_required_marker
          text = ""
          text << marker if required?(attribute) && @@settings.label_required_marker_position == :prepend
          text << field_human_name(attribute)
          text << marker if required?(attribute) && @@settings.label_required_marker_position == :append
          options.reverse_merge!(:caption => text, :class => css_class(attribute,type,options[:disabled]))
          @template.label_tag(field_id(attribute), options)
        end
        
        def css_class(attribute,type,disabled=false)
          klass = type.to_s
          klass << ' required' if required?(attribute)
          klass << ' required' if disabled
          klass
        end
        
        def html_options(attribute,type,options)
          options.keep_if {|key, value| key != :as}
          html_class = options.merge(:class => css_class(attribute,type,options[:disabled]))
          input_html = options[:input_html]
          if input_html
            html_class.merge(input_html) {|key, first, second| first + " " + second }.delete(:input_html)
          else
            html_class
          end
        end
        
        def labelize(options)
          opts = {}.merge(options)
          opts.keep_if {|key, value| [:class,:id,:caption].include?(key)}
        end
        
        def hint(text)
          @template.content_tag(:span, :class=>'hint') { text }
        end
        
        def default_radios(attribute,type,options)
          [['yes',1],['no',0]].map do |item|
            collection_input(attribute,:radios,item,options.keep_if {|key, value| key != :options})
          end.join("")
        end
        
        def klazz
          @object.class
        end
        
      end # StandardFormBuilder
    end # FormBuilder
  end # Helpers
end # Padrino