$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "qoqocms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "qoqocms"
  s.version     = Qoqocms::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Qoqocms."
  s.description = "TODO: Description of Qoqocms."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency 'sass-rails',   '~> 3.2.3'
  s.add_dependency 'coffee-rails', '~> 3.2.1'
  s.add_dependency 'compass-rails'
  s.add_dependency 'uglifier', '>= 1.0.3'

  s.add_dependency "jquery-rails"
  s.add_dependency 'haml-rails'
  s.add_dependency 'will_paginate'

  s.add_dependency 'clearance'
  s.add_dependency 'awesome_nested_set'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'russian'

  s.add_development_dependency "sqlite3"
end
