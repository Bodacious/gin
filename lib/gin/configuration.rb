module Gin
  
  class Configuration
    
    # Controller access resources via instance variables...
    # This will come into play with later versions
    attr_accessor :access_resources_via
    
    def initialize
      @access_resources_via = :instance_variables
    end
    
  end
  
end