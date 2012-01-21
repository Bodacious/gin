module Gin
  module DryController
    
    # This module will be implemented in a future version
    module ResourceHelpers

      def self.included(base)
        base.extend(ClassMethods) 

        base.class_eval do
          puts 'this was included'
          private

          helper_method resource_plural_name, resource_singular_name
          define_method resource_plural_name do
            eval("@#{resource_plural_name} ||= #{resource_class_name.constantize}.all")
          end
          
          define_method resource_singular_name do
            eval <<-CODE
              @#{resource_singular_name} ||= 
              if action_name =~ /new|create/
                #{resource_class_name.constantize}.new(params[:#{resource_singular_name}])
              else
                #{resource_class_name.constantize}.find(params[:id])
              end
            CODE
          end

        end

      end
      
      private

      def resource_class_name
        self.class.resource_class_name
      end

      def resource_plural_name
        self.class.resource_plural_name
      end

      def resource_singular_name
        self.class.resource_singular_name
      end

      module ClassMethods

        def resource_class_name
          controller_name.singularize.classify
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