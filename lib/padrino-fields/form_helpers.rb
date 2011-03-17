module Padrino
  module Helpers
    module FormHelpers
      
      %w(date date email number search tel url).each do |type|
        class_eval <<-EOF
        ##
        # Constructs a #{type} field input from the given options
        #
        # ==== Examples
        #
        #   #{type}_field_tag :username, :class => 'long'
        #
        def #{type}_field_tag(name, options={})
          options.reverse_merge!(:name => name)
          input_tag(:#{type}, options)
        end
        EOF
      end
      
      def select_tag(name, options={})
        options.reverse_merge!(:name => name)
        collection, fields = options.delete(:collection), options.delete(:fields)
        options[:options] = options_from_collection(collection, fields) if collection
        prompt = options.delete(:include_blank)
        select_options_html = if options[:options]
          options_for_select(options.delete(:options), options.delete(:selected))
        elsif options[:grouped_options]
          grouped_options_for_select(options.delete(:grouped_options), options.delete(:selected), prompt)
        end.unshift(blank_option(prompt))
        options.merge!(:name => "#{options[:name]}[]") if options[:multiple]
        content_tag(:select, select_options_html, options)
      end

      def grouped_options_for_select(collection,selected=nil,prompt=false)
        if collection.is_a?(Hash)
          collection.map do |key, value|
            content_tag :optgroup, :label => key do
              options_for_select(value, selected)
            end
          end
        elsif collection.is_a?(Array)
          collection.map do |optgroup|
            content_tag :optgroup, :label => optgroup.first do
              options_for_select(optgroup.last, selected)
            end
          end
        end.unshift(blank_option(prompt))
      end
      
      def blank_option(prompt)
        if prompt
          case prompt.class.to_s
          when 'String' ; content_tag(:option, prompt, :value => '') ;
          when 'Array'  ; content_tag(:option, prompt.first, :value => prompt.last) ;
          else          ; content_tag(:option, '', :value => '') ;
          end
        end
      end

    end # FormHelpers
  end # Helpers
end # Padrino