RSpec.configure do |config|
  # Automatically load all files in the 'support' folder
  Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }

  # Enable shared context metadata behavior
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Additional RSpec configuration
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Use random execution order to detect dependencies
  config.order = :random

  Kernel.srand config.seed
end
