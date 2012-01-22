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
        respond_to do |format|
          format.html{            
            if instance_variable_get("@#{resource_singular_name}").save
              redirect_to(redirect_url_on(:create), notice: flash_notice_on(:create))
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
        respond_to do |format|
          format.html{            
            if instance_variable_get("@#{resource_singular_name}").update_attributes(params[resource_singular_name])
              redirect_to(redirect_url_on(:update), notice: flash_notice_on(:update))
            else
              render :edit
            end
          }
        end
      end

      def destroy
        respond_to do |format|
          format.html{            
            instance_variable_get("@#{resource_singular_name}").destroy
            redirect_to(redirect_url_on(:destroy), notice: flash_notice_on(:destroy))
          }
        end
      end

    end
  end
end