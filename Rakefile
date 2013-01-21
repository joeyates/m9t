require 'bundler'
require 'bundler/gem_tasks'
require 'rake/testtask'

$:.unshift(File.dirname(__FILE__) + '/lib')
require 'm9t'

task :default => :test

Rake::TestTask.new do |t|
  t.libs       << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose    = true
end

if RUBY_VERSION < '1.9' and RUBY_PLATFORM != 'java'
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.test_files = FileList['test/*_test.rb']
    t.rcov_opts  << '--exclude /gems/'
  end
end

