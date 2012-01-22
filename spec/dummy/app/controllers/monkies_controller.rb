class MonkiesController < ApplicationController
  
  acts_as_a_dry_controller
  
  flash_notice_on_create "Monky successfully created"
  flash_notice_on_update lambda { |monkey| "Monky #{monkey.id} successfully updated" }
  flash_notice_on_destroy "Monky successfully destroyed"

  redirect_url_on_create lambda { monkies_url }
  redirect_url_on_update :index
  redirect_url_on_destroy lambda { monkies_url }
  
  resource_class Apple
  
end
