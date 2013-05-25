# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'rspec'
require 'rspec/autorun'

if RUBY_VERSION > '1.9' and RUBY_PLATFORM != 'java'
  require 'simplecov'
  if ENV['COVERAGE']
    SimpleCov.start do
      add_filter '/spec/'
    end
  end
end

require 'm9t'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

