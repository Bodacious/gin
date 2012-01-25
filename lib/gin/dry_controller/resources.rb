module Gin
  module DryController
    module Resources

      def self.included(base)
        base.extend(ClassMethods)
        base.before_filter(Gin::DryController::BeforeFilters::SetResourcePluralIvar.new, only: [:index])
        base.before_filter(Gin::DryController::BeforeFilters::SetResourceSingularIvar.new, only: [:new, :create, :show, :edit, :update, :destroy])
        base.respond_to(:html)
      end
      
      private
      
      def singular_ivar
        instance_variable_get("@#{resource_singular_name}")
      end

      def plural_ivar
        instance_variable_get("@#{resource_plural_name}")        
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
        
        def resource_class(class_name = nil)
          if class_name
            @resource_class = begin
              class_name.is_a?(Class) ? class_name : class_name.to_s.classify.constantize
            end
          else
            @resource_class ||= controller_name.singularize.classify.constantize
          end          
        end
        
        def resource_plural_name
          resource_singular_name.pluralize
        end

        def resource_singular_name
          resource_class.to_s.underscore.singularize
        end

      end
    end
  end
end