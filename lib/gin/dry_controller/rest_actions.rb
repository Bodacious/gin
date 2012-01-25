module Gin
  module DryController
    module RestActions
      
      def self.included(base)
        base.extend ClassMethods
      end
      
      def index
        respond_with plural_ivar
      end

      def new
        respond_with singular_ivar
      end

      def create
        respond_with(singular_ivar, :status => 201) do |format|
          if singular_ivar.save
            format.html {
              redirect_to(redirect_url_on(:create), notice: flash_notice_on(:create))  
            }
          else
            format.html { render :new }
          end
        end
      end

      def show
        respond_with(singular_ivar)
      end

      def edit
        respond_with(singular_ivar)
      end

      def update
        respond_with(singular_ivar) do |format|
          format.html {
            if singular_ivar.update_attributes(params[resource_singular_name])
              redirect_to(redirect_url_on(:update), notice: flash_notice_on(:update))
            else
              render :edit
            end            
          }
        end
      end

      def destroy
        respond_with(singular_ivar) do |format|
          format.html{            
            singular_ivar.destroy
            redirect_to(redirect_url_on(:destroy), notice: flash_notice_on(:destroy))
          }
        end
      end
      
      module ClassMethods
        
        def exclude_actions(*args)
          undef_method *args
        end
        
      end
            
    end
  end
end