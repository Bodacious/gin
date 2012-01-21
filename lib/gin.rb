require "gin/configuration"

if defined?(ActionController)
  require "gin/dry_controller"
  require "gin/railtie"
else
  warn "ActionController not defined! Gin extends the behaviour of ActionController."
end

module Gin
  
  def self.configuration
    @configuration ||= Gin::Configuration.new
  end
  
  def self.configure(&block)
    yield(configuration)
  end
  
end
