require 'webmock/rspec'
require 'simplecov'

SimpleCov.start
WebMock.disable_net_connect!(allow_localhost: true)

require_relative '../lib/sapcai'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.default_formatter = 'doc' if config.files_to_run.one?
end
