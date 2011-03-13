require 'sinatra'
require 'padrino'
require 'padrino-core/support_lite' unless defined?(SupportLite)
require 'cgi'
require 'i18n'
require 'enumerator'

FileSet.glob_require('padrino-fields/**/*.rb', __FILE__)

# Load our locales
I18n.load_path += Dir["#{File.dirname(__FILE__)}/padrino-helpers/locale/*.yml"]

module PadrinoFields
  ##
  # This component provides view helpers and shortcuts for generating form fields
  # Should feel familiar to users of Formtastic or SimpleForm

    ##
    # Register Padrino::Helpers::Fields for Padrino::Application
    #
    class << self
      def registered(app)
        app.set :default_builder, 'StandardFormBuilder'
        app.helpers Padrino::Helpers::FormBuilder::PadrinoFieldsBuilder
        rescue
      end
      alias :included :registered
    end
            
end # PadrinoFields