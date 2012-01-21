class MonkiesController < ApplicationController
  
  acts_as_a_dry_controller
  
  flash_notice_on_create "Monky successfully created"
  flash_notice_on_update "Monky successfully updated"
  flash_notice_on_destroy "Monky successfully destroyed"

  redirect_after_create /monkies
  redirect_after_update /monkies
  redirect_after_destroy /monkies

  
end
