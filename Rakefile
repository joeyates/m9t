require 'bundler'
require 'rake/testtask'

$:.unshift( File.dirname(__FILE__) + '/lib' )
require 'm9t'

task :default => :test

Rake::TestTask.new do |t|
  t.libs       << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose    = true
end

if RUBY_VERSION < '1.9'
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.test_files = FileList['test/*_test.rb']
    t.rcov_opts  << '--exclude /gems/'
  end
end

desc "Build the gem"
task :build do
  `gem build m9t.gemspec`
end

desc "Publish a new version of the gem"
task :release => :build do
  `gem push m9t-#{M9t::VERSION::STRING}.gem`
end
