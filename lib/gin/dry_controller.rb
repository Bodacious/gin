require "gin/dry_controller/rest_actions"

module Gin

  module DryController

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def acts_as_a_dry_controller
        if Gin.configuration.access_resources_via == :instance_variables
          require "gin/dry_controller/resource_instance_variables"          
          send(:include, Gin::DryController::ResourceInstanceVariables)
        else
          require "gin/dry_controller/resource_helpers"          
          send(:include, Gin::DryController::ResourceHelpers)          
        end
        send(:include, Gin::DryController::RestActions)
      end

    end
  end

end