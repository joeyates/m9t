# -*- encoding: utf-8 -*-
$:.unshift( File.dirname(__FILE__) + '/lib' )
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

  s.files         = `git ls-files`.lines.map( &:chomp! ).reject { | f | f[ 0 .. 0 ] == '.' }
  s.test_files    = `git ls-files`.lines.map( &:chomp! ).select { | f | f =~ /_test.rb$/ }
  s.require_paths = ['lib']

  s.rubyforge_project = 'nowarning'

  s.add_dependency 'rake'                  if RUBY_VERSION < '1.9'
  s.add_dependency 'rake', '~> 0.8.7'      if RUBY_VERSION > '1.9'
  s.add_dependency 'i18n', '>= 0.3.5'

  s.add_development_dependency 'rcov'      if RUBY_VERSION < '1.9'
  s.add_development_dependency 'simplecov' if RUBY_VERSION > '1.9'
end
