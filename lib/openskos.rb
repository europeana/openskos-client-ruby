require "openskos/version"
require "active_support/core_ext"

module OpenSKOS
  autoload :Concept,  'openskos/concept'
  autoload :Errors,   'openskos/errors'
  
  class << self
    # @return [String] the base URL at which OpenSKOS is accessed
    attr_accessor :url
    
    ##
    # Sets configuration values to their defaults
    #
    def defaults!
      self.url = nil
    end
  end
  
  self.defaults!
end
