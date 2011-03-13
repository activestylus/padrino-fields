module PadrinoFields
  module Settings

    mattr_accessor :container
    @@container = :p
    
    mattr_accessor :label_required_marker
    @@label_required_marker = "<abbr>*</abbr>"
    
    mattr_accessor :label_required_marker_position
    @@label_required_marker_position = :prepend
    
    def self.configure
      yield self
    end
    
  end
end