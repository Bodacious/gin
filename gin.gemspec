$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gin"
  s.version     = Gin::VERSION
  s.authors     = ["Gavin Morrice"]
  s.email       = ["gavin@gavinmorrice.com"]
  s.homepage    = "http://rubydoc.info/gems/gin/frames"
  s.summary     = "Cool, DRY controllers!"
  s.description = "Modules for DRYer controllers"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.1.2"

  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'mocha'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", '~> 2.8.1'  
end
