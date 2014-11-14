Gem::Specification.new do |s|
  s.name        = 'cloudsight'
  s.version     = '0.0.1'
  s.date        = '2014-11-14'
  s.summary     = "CloudSight API Client"
  s.description = "A simple CloudSight API Client for Image Recognition"
  s.authors     = ['Brad Folkens']
  s.email       = 'brad@cloudsightapi.com'
  s.files       = [
		'lib/cloudsight.rb',
		'Gemfile',
		'Gemfile.lock',
		'MIT-LICENSE',
		'cloudsight.gemspec'
	]
  s.homepage    = 'http://github.com/cloudsight/cloudsight-ruby'
	s.license			= 'MIT'
	s.required_ruby_version = Gem::Requirement.new(">= 1.9.1")
	s.require_paths = [%q{lib}]
end
