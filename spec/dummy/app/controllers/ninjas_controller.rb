class NinjasController < ApplicationController

  acts_as_a_dry_controller  

  flash_notice_on_create "Ninja successfully created"
  flash_notice_on_update "Ninja successfully updated"
  flash_notice_on_destroy "Ninja successfully destroyed"

  redirect_url_on_create lambda { |ninja| ninja_url(ninja) }
  redirect_url_on_update lambda { ninjas_url }
  redirect_url_on_destroy lambda { ninjas_url }
  
  resource_class :apple
  
end
