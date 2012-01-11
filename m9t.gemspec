# -*- encoding: utf-8 -*-
$:.unshift( File.dirname(__FILE__) + '/lib' )
require 'm9t/version'
require 'rake'

gemspec = Gem::Specification.new do |s|
  s.name        = 'm9t'
  s.platform    = Gem::Platform::RUBY
  s.version     = M9t::VERSION::STRING

  s.summary     = 'Classes for handling measurement units'
  s.description = 'Classes for handling measurement units, conversions and translations'

  s.homepage    = 'https://github.com/joeyates/m9t'
  s.author      = 'Joe Yates'
  s.email       = 'joe.g.yates@gmail.com'

  s.files         = ['README.rdoc', 'COPYING', 'Rakefile'] + Rake::FileList['{lib,test}/**/*.rb'] + FileList['locales/**/*.{rb,yml}']
  s.require_paths = ['lib']

  s.add_dependency 'rake', '>= 0.8.7'
  s.add_dependency 'i18n', '>= 0.3.5'

  s.add_development_dependency 'rcov'

  s.test_file = 'test/test_all.rb'

  s.rubyforge_project = 'nowarning'
end
