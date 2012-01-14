# -*- encoding: utf-8 -*-
$:.unshift( File.dirname(__FILE__) + '/lib' )
require 'm9t/version'

gemspec = Gem::Specification.new do |s|
  s.name          = 'm9t'
  s.platform      = Gem::Platform::RUBY
  s.version       = M9t::VERSION::STRING

  s.summary       = 'Measurements and coversions library for Ruby'
  s.description   = 'Measurements and coversions library for Ruby'

  s.homepage      = 'https://github.com/joeyates/m9t'
  s.author        = 'Joe Yates'
  s.email         = 'joe.g.yates@gmail.com'

  s.files         = `git ls-files`.map( &:chomp! ).reject{ | f | f[ 0 .. 0 ] == '.' }
  s.require_paths = ['lib']

  s.add_dependency 'rake'                  if RUBY_VERSION < '1.9'
  s.add_dependency 'rake', '~> 0.8.7'      if RUBY_VERSION > '1.9'
  s.add_dependency 'i18n', '>= 0.3.5'

  s.add_development_dependency 'rcov'      if RUBY_VERSION < '1.9'
  s.add_development_dependency 'simplecov' if RUBY_VERSION > '1.9'

  s.test_file = 'test/test_all.rb'

  s.rubyforge_project = 'nowarning'
end
