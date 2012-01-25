class ChickensController < ApplicationController
  
  acts_as_a_dry_controller
  
  redirect_url_on_create lambda { |c| { action: "show", id: c.id, apple_id: c.apple_id } }
  
  exclude_actions :edit, :update, :destroy
  
  private
  
  def set_chickens
    @apple = Apple.find(params[:apple_id])
    @chickens = @apple.chickens
  end
  
  def set_chicken
    @apple = Apple.find(params[:apple_id])
    
    if action_name =~ /new|create/
      @chicken = @apple.chickens.new(params[:chicken])
    else
      @chicken = @apple.chickens.find(params[:id])
    end
    
  end

end
