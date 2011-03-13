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
        select_options_html = options_for_select(options.delete(:options), options.delete(:selected))
        options.merge!(:name => "#{options[:name]}[]") if options[:multiple]
        content_tag(:select, select_options_html, options)
      end

    end # FormHelpers
  end # Helpers
end # Padrino