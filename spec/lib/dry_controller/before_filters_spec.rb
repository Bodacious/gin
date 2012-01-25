require "spec_helper"

describe Gin::DryController::BeforeFilters do
  
  let(:controller_class) {
    c = Class.new(ActionController::Base)
    c.send(:include, Gin::DryController::Resources)
    c.stubs(:controller_name).returns("pomegranates")
    c
  }
  let(:controller_instance) { controller_class.new }
  

  before do
    controller_class.resource_class Apple
    Apple.expects(:all).returns(@_apples = [])
  end

  it 'sets the plural instance variable to :class.all'

  it 'sets the singular instance variable to a new record if :new or :create'

end
