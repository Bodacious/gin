module Gin
  module DryController

    require "gin/dry_controller/resources"
    require "gin/dry_controller/flash_notices"
    require "gin/dry_controller/redirects"    
    require "gin/dry_controller/rest_actions"
    require "gin/dry_controller/before_filters"

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      # Defines a Controller as a DRY controller 
      # and fills it with all the Gin goodness *(hic!)*
      def acts_as_a_dry_controller
        class_eval do
          include Gin::DryController::Resources
          include Gin::DryController::FlashNotices          
          include Gin::DryController::Redirects                    
          include Gin::DryController::RestActions
        end
      end

    end
  end

end