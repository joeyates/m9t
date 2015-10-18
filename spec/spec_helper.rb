require "codeclimate-test-reporter"
require 'rspec'

CodeClimate::TestReporter.start

if RUBY_PLATFORM != 'java'
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'm9t'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
