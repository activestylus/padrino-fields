module PadrinoFields
  module Settings

    mattr_accessor :container
    @@container = :p
    
    mattr_accessor :container_class
    @@container_class = ""
    
    mattr_accessor :control_container
    @@control_container = nil
    
    mattr_accessor :control_container_class
    @@control_container_class = ""
    
    mattr_accessor :hint_container
    @@hint_container = :span
    
    mattr_accessor :hint_container_class
    @@hint_container_class = "hint"
    
    mattr_accessor :error_message_options
    @@error_message_options = {}
    
    mattr_accessor :label_class
    @@label_class = ""
    
    mattr_accessor :label_required_marker
    @@label_required_marker = "<abbr>*</abbr>"
    
    mattr_accessor :label_required_marker_position
    @@label_required_marker_position = :prepend
    
    def self.configure
      yield self
    end
    
  end
end