module Gin

  class Railtie < ::Rails::Railtie
    
    # Add a to_prepare block which is executed once in production
    # and before each request in development
    config.to_prepare do
      ActionController::Base.send(:include, Gin::DryController)
    end
    
    # initializer "gin_railtie.configure_rails_initialization" do
    # 
    # end
    
  end

end

