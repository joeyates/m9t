# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'm9t/version'

gemspec = Gem::Specification.new do |s|
  s.name          = 'm9t'
  s.platform      = Gem::Platform::RUBY
  s.version       = M9t::VERSION::STRING
  s.required_ruby_version = '>= 1.9.3'

  s.summary       = 'Measurements and conversions library for Ruby'
  s.description   = 'Classes for handling basic measurement units: distance, direction, speed, temperature and pressure'
  s.license       = "MIT"

  s.homepage      = 'https://github.com/joeyates/m9t'
  s.author        = 'Joe Yates'
  s.email         = 'joe.g.yates@gmail.com'

  s.files         = `git ls-files`.lines.map(&:chomp!)
  s.test_files    = `git ls-files spec`.lines.map(&:chomp!)
  s.require_paths = ['lib']

  s.rubyforge_project = 'nowarning'

  s.add_dependency 'rake'
  s.add_dependency 'i18n', '>= 0.3.5'

  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.8'
  s.add_development_dependency 'rspec', '>= 3.0.0'
  s.add_development_dependency 'simplecov' if RUBY_PLATFORM != 'java'
end
