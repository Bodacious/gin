module Gin
  module DryController
    module ResourceInstanceVariables

      def self.included(base)
        base.extend(ClassMethods)         
        base.before_filter :set_resource_plural_instance_variable, only: [:index]
        base.before_filter :set_resource_singular_instance_variable, only: [:new, :create, :show, :edit, :update, :destroy]
      end
      
      private
      
      def set_resource_plural_instance_variable
        instance_variable_set("@#{resource_plural_name}", resource_class.all)
      end
      
      def set_resource_singular_instance_variable
        instance_variable_set("@#{resource_singular_name}", resource_singular_instance_variable)
      end
      
      def resource_singular_instance_variable
        if action_name =~ /new|create/
          new_resource_singular_instance_variable
        else
          existing_resource_singular_instance_variable
        end 
      end
      
      def new_resource_singular_instance_variable
        resource_class.new(params[resource_singular_name])
      end
      
      def existing_resource_singular_instance_variable
        resource_class.find(params[:id])
      end


      def resource_class
        self.class.resource_class
      end

      def resource_plural_name
        self.class.resource_plural_name
      end

      def resource_singular_name
        self.class.resource_singular_name
      end

      module ClassMethods

        def resource_class
          controller_name.singularize.classify.constantize
        end

        def resource_plural_name
          controller_name.pluralize
        end

        def resource_singular_name
          controller_name.singularize
        end

      end
    end
  end
end