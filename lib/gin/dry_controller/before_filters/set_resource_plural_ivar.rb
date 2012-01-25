module Gin
  module DryController
    module BeforeFilters
      class SetResourcePluralIvar
        
        def before(controller)
          plural_name = controller.send(:resource_plural_name)
          
          if controller.respond_to?("set_#{plural_name}", true)
            controller.send("set_#{plural_name}") and return
          end
          
          klass       = controller.send(:resource_class)
          controller.instance_variable_set("@#{plural_name}", klass.all)
        end
        
      end
    end
  end
end