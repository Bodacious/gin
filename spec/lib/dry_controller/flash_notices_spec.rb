require "spec_helper"

describe Gin::DryController::FlashNotices do
  
  # Create a new controller class to inherit our Module
  let(:raw_controller) { 
    c = Class.new(ActionController::Base) 
    c.stubs(:controller_name).returns('pomegranates')
    c
  }
  let(:controller) { 
    c = raw_controller
    c.acts_as_a_dry_controller
    c
  }
  
  let(:controller_instance) { controller.new }
  
  let(:pomegranate) { 
    p = Object.new
    p.stubs(:id).returns("1")
    p
  }
  
  it 'sets the default created flash message to ":resource_name successfully created!"' do
    controller_instance.flash_notice_on(:create).should eql("Pomegranate successfully created!")    
  end

  it 'overrides the flash notice on create' do
    controller.flash_notice_on_create("A tall chap with a wooden leg")
    controller_instance.flash_notice_on(:create).should eql("A tall chap with a wooden leg")
  end
  
  it 'accepts a proc with the resource as an argument on create ' do
    controller.flash_notice_on_create lambda { |r| "Successfully created Pomegranate #{r.id}" }
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.flash_notice_on(:create).should eql("Successfully created Pomegranate 1")
  end

  it 'sets the default updated flash message to ":resource_name successfully updated!"' do
    controller_instance.flash_notice_on(:update).should eql("Pomegranate successfully updated!")    
  end

  it 'overrides the flash notice on update' do
    controller.flash_notice_on_update("The Mask was Jim Carey's best film")
    controller_instance.flash_notice_on(:update).should eql("The Mask was Jim Carey's best film")
  end
  
  it 'accepts a proc with the resource as an argument on update ' do
    controller.flash_notice_on_update lambda { |r| "Successfully updated Pomegranate #{r.id}" }
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.flash_notice_on(:update).should eql("Successfully updated Pomegranate 1")
  end
  
  it 'sets the default destroyed flash message to ":resource_name successfully destroyed!"' do
    controller_instance.flash_notice_on(:destroy).should eql("Pomegranate successfully destroyed!")    
  end

  it 'overrides the flash notice on destroy' do
    controller.flash_notice_on_destroy("Lilliputs haunt me in my sleep")
    controller_instance.flash_notice_on(:destroy).should eql("Lilliputs haunt me in my sleep")
  end
  
  it 'accepts a proc with the resource as an argument on destroy ' do
    controller.flash_notice_on_destroy lambda { |r| "Successfully destroyed Pomegranate #{r.id}" }
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.flash_notice_on(:destroy).should eql("Successfully destroyed Pomegranate 1")
  end
  
end