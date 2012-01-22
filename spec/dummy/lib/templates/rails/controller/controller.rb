<% module_namespacing do -%>
class <%= class_name %>Controller < ApplicationController
  
  acts_as_a_dry_controller
  
  flash_notice_on_create "<%= human_name.singularize %> successfully created"
  flash_notice_on_update "<%= human_name.singularize %> successfully updated"
  flash_notice_on_destroy "<%= human_name.singularize %> successfully destroyed"

  redirect_after_create <%= plural_name %>_url
  redirect_after_update <%= plural_name %>_url
  redirect_after_destroy <%= plural_name %>_url
  
<% actions.each do |action| -%>
  def <%= action %>
  end
<%= "\n" unless action == actions.last -%>
<% end -%>
end
<% end -%>
