module Padrino
  module Fields
    module Settings
  
      mattr_accessor :container
      @@container = :p
      
      mattr_accessor :label_required_marker
      @@label_required_marker = "<abbr>*</abbr>"
      
      mattr_accessor :label_required_marker_position
      @@label_required_marker_position = :prepend
      
      def self.setup
        yield self
      end
      
    end
  end
end