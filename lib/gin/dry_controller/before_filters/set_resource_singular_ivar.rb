module Gin
  module DryController
    module BeforeFilters
      class SetResourceSingularIvar

        def before(controller)
          single_name = controller.send(:resource_singular_name)
          
          if controller.respond_to?("set_#{single_name}", true)
            controller.send("set_#{single_name}") and return
          end
          
          klass       = controller.send(:resource_class)
          params      = controller.params

          i_var = 
          if controller.action_name =~ /new|create/
            klass.new(params[single_name])
          else
            klass.find(params[:id])
          end          
          controller.instance_variable_set("@#{single_name}", i_var)
        end

      end

    end
  end
end