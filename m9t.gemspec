# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'm9t/version'

gemspec = Gem::Specification.new do |s|
  s.name          = 'm9t'
  s.platform      = Gem::Platform::RUBY
  s.version       = M9t::VERSION::STRING

  s.summary       = 'Measurements and conversions library for Ruby'
  s.description   = 'Classes for handling basic measurement units: distance, direction, speed, temperature and pressure'

  s.homepage      = 'https://github.com/joeyates/m9t'
  s.author        = 'Joe Yates'
  s.email         = 'joe.g.yates@gmail.com'

  s.files         = `git ls-files`.lines.map(&:chomp!)
  s.test_files    = `git ls-files spec`.lines.map(&:chomp!)
  s.require_paths = ['lib']

  s.rubyforge_project = 'nowarning'

  s.add_dependency 'rake'
  s.add_dependency 'i18n', '>= 0.3.5'

  s.add_development_dependency 'rspec', '>= 3.0.0'
  if RUBY_VERSION < '1.9'
    s.add_development_dependency 'rcov' if RUBY_PLATFORM != 'java'
  else
    s.add_development_dependency 'simplecov' if RUBY_PLATFORM != 'java'
  end
end

