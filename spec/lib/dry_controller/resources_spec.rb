require "spec_helper"

describe Gin::DryController::Resources do

  let(:controller_class) {
    c = Class.new(ActionController::Base)
    c.send(:include, Gin::DryController::Resources)
    c.stubs(:controller_name).returns("pomegranates")
    c
  }
  let(:controller_instance) { controller_class.new }


  context 'defaults' do

    it 'sets the resource class name from the controller name' do
      controller_class.resource_class.should eql(Pomegranate)
      controller_instance.send(:resource_class).should eql(Pomegranate)        
    end

    it 'sets the resource plural name' do
      controller_class.resource_plural_name.should eql('pomegranates')
      controller_instance.send(:resource_plural_name).should eql('pomegranates')
    end

    it 'sets the resource singular name' do
      controller_class.resource_singular_name.should eql('pomegranate')
      controller_instance.send(:resource_singular_name).should eql('pomegranate')        
    end

  end

  context 'set with Class' do

    before do
      controller_class.resource_class(Apple)
    end

    it 'sets the resource class' do
      controller_class.resource_class.should eql(Apple)
      controller_instance.send(:resource_class).should eql(Apple)        
    end

    it 'sets the resource plural name' do
      controller_class.resource_plural_name.should eql('apples')
      controller_instance.send(:resource_plural_name).should eql('apples')
    end

    it 'sets the resource singular name' do
      controller_class.resource_singular_name.should eql('apple')
      controller_instance.send(:resource_singular_name).should eql('apple')        
    end

  end

  context 'set with string' do

    before do
      controller_class.resource_class('apple')
    end

    it 'sets the resource class' do
      controller_class.resource_class.should eql(Apple)
      controller_instance.send(:resource_class).should eql(Apple)        
    end

    it 'sets the resource plural name' do
      controller_class.resource_plural_name.should eql('apples')
      controller_instance.send(:resource_plural_name).should eql('apples')        
    end

    it 'sets the resource singular name' do
      controller_class.resource_singular_name.should eql('apple')
      controller_instance.send(:resource_singular_name).should eql('apple')
    end

  end

  context 'set with symbol' do

    before do
      controller_class.resource_class(:apple)
    end

    it 'sets the resource class' do
      controller_class.resource_class.should eql(Apple)
      controller_instance.send(:resource_class).should eql(Apple)        
    end

    it 'sets the resource plural name' do
      controller_class.resource_plural_name.should eql('apples')
      controller_instance.send(:resource_plural_name).should eql('apples')
    end

    it 'sets the resource singular name' do
      controller_class.resource_singular_name.should eql('apple')
      controller_instance.send(:resource_singular_name).should eql('apple')
    end

  end
end