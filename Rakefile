require 'rubygems'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rake/clean'

$:.unshift( File.dirname(__FILE__) + '/lib' )
require 'bundler/version'
require 'm9t'

RDOC_OPTS = ['--quiet', '--title', 'm9t: Measurement units', '--main', 'README.rdoc', '--inline-source']
CLEAN.include 'doc'

task :default => :test

Rake::TestTask.new do |t|
  t.libs       << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose    = true
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc/rdoc'
  rdoc.options  += RDOC_OPTS
  rdoc.main     = 'README.rdoc'
  rdoc.rdoc_files.add ['README.rdoc', 'COPYING', 'lib/**/*.rb']
end

desc "Build the gem"
task :build do
  `gem build m9t.gemspec`
end

desc "Publish a new version of the gem"
task :release => :build do
  `gem push m9t-#{M9t::VERSION::STRING}`
end
