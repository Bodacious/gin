require "spec_helper"

describe Gin::DryController::Redirects do
  
  # Create a new controller class to inherit our Module
  let(:raw_controller) { 
    c = Class.new(ActionController::Base)
    c.stubs(:pomegranate_url).with(pomegranate).returns('/pomegranates/1')
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
    c = Object.new
    c.stubs(:id).returns("1")
    c.stubs(:class_name).returns("pomegranate")
    c
  }
  
  it 'sets the default created redirect url to /pomegranates/1' do
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.redirect_url_on(:create).should eql(pomegranate)
  end

  it 'overrides the redirect url on create' do
    controller.redirect_url_on_create("http://google.com")
    controller_instance.redirect_url_on(:create).should eql("http://google.com")
  end
  
  it 'accepts a proc with the resource as an argument on create ' do
    controller.redirect_url_on_create lambda { |r| "/underpant_informants/#{r.id}" }
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.redirect_url_on(:create).should eql("/underpant_informants/1")
  end
  
  it 'sets the default updated redirect url to /pomegranates/1' do
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.redirect_url_on(:update).should eql(pomegranate)
  end

  it 'overrides the redirect url on update' do
    controller.redirect_url_on_update("http://buyawesomeknives.com")
    controller_instance.redirect_url_on(:update).should eql("http://buyawesomeknives.com")
  end

  it 'accepts a proc with the resource as an argument on update ' do
    controller.redirect_url_on_update lambda { |r| "/poorly_written_songs/#{r.id}" }
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.redirect_url_on(:update).should eql("/poorly_written_songs/1")
  end
  
  it 'sets the default destroyed redirect url to index' do
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.redirect_url_on(:destroy).should eql({:action=>"index"})
  end

  it 'overrides the redirect url on destroy' do
    controller.redirect_url_on_destroy("http://wolfpack.com")
    controller_instance.redirect_url_on(:destroy).should eql("http://wolfpack.com")
  end

  it 'accepts a proc with the resource as an argument on destroy ' do
    controller.redirect_url_on_destroy lambda { |r| "/#{r.class_name.downcase.pluralize}" }
    controller_instance.instance_variable_set('@pomegranate', pomegranate)
    controller_instance.redirect_url_on(:destroy).should eql("/pomegranates")
  end

end