module Gin
  module DryController
    module RestActions
      
      def index
        respond_to do |format|
          format.html{}
        end
      end
      
      def new
        respond_to do |format|
          format.html{}
        end
      end
      
      def create
        _resource  = instance_variable_get("@#{resource_singular_name}")        
        respond_to do |format|
          format.html{            
            if _resource.save
              redirect_to(_resource, notice: "Successfully created #{resource_singular_name.capitalize}")
            else
              render :new
            end
          }
        end
      end

      def show
        respond_to do |format|
          format.html{}
        end
      end
      
      def edit
        respond_to do |format|
          format.html {}
        end
      end
      
      def update
        _resource  = instance_variable_get("@#{resource_singular_name}")
        respond_to do |format|
          format.html{            
            if _resource.update_attributes(params[resource_singular_name])
              redirect_to(_resource, notice: "Successfully updated #{resource_singular_name.capitalize}")
            else
              render :edit
            end
          }
        end
      end
    end
  end
end