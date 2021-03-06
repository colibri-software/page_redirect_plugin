# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'page_redirect_plugin/version'


Gem::Specification.new do |s|

  s.name        = 'page_redirect_plugin'
  s.version     = PageRedirectPlugin::VERSION
  s.date        = '2013-04-24'
  s.summary     = "provides a easy way of redirecting"
  s.description = "provides a easy way of redirecting"
  s.authors     = ["Colibri Software Inc."]
  s.email       = 'info@colibri-software.com'
  #s.files       = `git ls-files`.split($/)
  s.files       = Dir["{lib}/**/*"]
  s.homepage    = 'http://colibri-software.com'
  s.require_paths = ['lib']
  s.add_dependency "locomotive_plugins", '~> 1.0.1'
  s.add_dependency "mongoid"

  s.add_development_dependency "rspec", '~> 2.12'
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "mocha"
end


