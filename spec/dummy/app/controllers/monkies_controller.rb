class MonkiesController < ApplicationController
  
  acts_as_a_dry_controller
  
  flash_notice_on_create "Monky successfully created - yay!"
  flash_notice_on_update lambda { |monkey| "Monky #{monkey.id} successfully updated" }
  # flash_notice_on_destroy "Monky successfully destroyed"

  redirect_url_on_create action: 'index'
  redirect_url_on_update lambda { |m| {action: "show", id: m.id} }
  redirect_url_on_destroy 'http://nooooooooooooooo.com/'
  
  resource_class Apple
  
  exclude_actions :index
    
end
