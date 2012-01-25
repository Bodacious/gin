class ApplesController < ApplicationController

  acts_as_a_dry_controller
  
  respond_to :json    
end
