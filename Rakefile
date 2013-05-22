#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rcov/rcovtask' if RUBY_VERSION < '1.9'
require 'rspec/core/rake_task'

task :default => :spec

Rake::TestTask.new do |t|
  t.libs       << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose    = true
end

RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

if RUBY_VERSION < '1.9'
  RSpec::Core::RakeTask.new('spec:rcov') do |t|
    t.pattern   = 'spec/**/*_spec.rb'
    t.rcov      = true
    t.rcov_opts = ['--exclude', 'spec/,/gems/']
  end
end

