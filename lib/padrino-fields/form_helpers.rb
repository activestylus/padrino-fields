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
        blank = options.delete(:include_blank)
        options[:options].to_a.unshift(blank.is_a?(String) ? [blank, ''] : '') if blank
        select_options_html = if options[:options]
          options_for_select(options.delete(:options), options.delete(:selected))
        elsif options[:grouped_options]
          grouped_options_for_select(options.delete(:grouped_options), options.delete(:selected))
        end
        options.merge!(:name => "#{options[:name]}[]") if options[:multiple]
        content_tag(:select, select_options_html, options)
      end

      def grouped_options_for_select(collection,selected=nil)
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
        else
          raise "options must be a hash or array, not a #{collection.class}"
        end
      end
      
      

    end # FormHelpers
  end # Helpers
end # Padrino