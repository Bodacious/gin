# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'support/specs_controller'
include Gin

RSpec.configure do |config|
  config.mock_with :mocha
end

