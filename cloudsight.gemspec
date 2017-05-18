# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'cloudsight/version'

Gem::Specification.new do |s|
  s.name        = 'cloudsight'
  s.version     = Cloudsight::VERSION
  s.date        = '2015-11-05'
  s.summary     = "CloudSight API Client"
  s.description = "A simple CloudSight API Client for Image Recognition"
  s.authors     = ['Brad Folkens']
  s.email       = 'brad@cloudsightapi.com'
  s.homepage    = 'http://github.com/cloudsight/cloudsight-ruby'
  s.license			= 'MIT'
  s.platform    = Gem::Platform::RUBY

  s.files       = [
    'lib/cloudsight.rb',
    'Gemfile',
    'Gemfile.lock',
    'MIT-LICENSE',
    'README.md',
    'cloudsight.gemspec'
  ]
  s.require_paths = [%q{lib}]

  s.required_ruby_version = Gem::Requirement.new('>= 1.9.1')

  s.add_dependency 'json'
  s.add_dependency 'rest-client', '~>1.6'
  s.add_dependency 'simple_oauth'

  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'rake'
end
