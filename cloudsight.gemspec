# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'cloudsight/version'

Gem::Specification.new do |s|
  s.name        = 'cloudsight'
  s.version     = Cloudsight::VERSION
  s.summary     = "CloudSight API Client"
  s.description = "A simple CloudSight API Client for Image Recognition"
  s.authors     = ['Brad Folkens', 'Jack McCallum', 'Chris Weilemann']
  s.email       = 'oss@cloudsight.ai'
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

  s.add_dependency 'json', '~> 2.1'
  s.add_dependency 'rest-client', '~> 2.0'

  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'pry', '~> 0.10'
  s.add_development_dependency 'webmock', '~> 3.0'
  s.add_development_dependency 'simple_oauth', '~> 0.3'
end
