require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rake/clean'

$:.unshift(File.dirname(__FILE__) + '/lib')
require 'm9t'

RDOC_OPTS = ['--quiet', '--title', 'm9t: Measurement units', '--main', 'README.rdoc', '--inline-source']
CLEAN.include 'doc'

task :default => :test

spec = Gem::Specification.new do |s|
  s.name        = 'm9t'
  s.summary     = 'Classes for handling measurement units'
  s.description = 'Classes for handling measurement units, conversions and translations'
  s.version     = M9t::VERSION::STRING

  s.homepage    = 'http://github.com/joeyates/m9t'
  s.author      = 'Joe Yates'
  s.email       = 'joe.g.yates@gmail.com'

  s.files         = ['README.rdoc', 'COPYING', 'Rakefile'] + FileList['{lib,test}/**/*.rb'] + FileList['locales/**/*.{rb,yml}']
  s.require_paths = ['lib']
  s.add_dependency('i18n', '>= 0.3.5')

  s.has_rdoc         = true
  s.rdoc_options     += RDOC_OPTS
  s.extra_rdoc_files = ['README.rdoc', 'COPYING']

  s.test_file = 'test/test_all.rb'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc/rdoc'
  rdoc.options  += RDOC_OPTS
  rdoc.main     = 'README.rdoc'
  rdoc.rdoc_files.add ['README.rdoc', 'COPYING', 'lib/**/*.rb']
end

Rake::GemPackageTask.new(spec) do |pkg|
end
