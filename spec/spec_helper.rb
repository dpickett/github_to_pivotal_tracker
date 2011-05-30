$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'github_to_pivotal_tracker'

configatron.github_to_pivotal_tracker.configure_from_yaml("#{File.dirname(__FILE__)}/configuration.yml")

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  # config.mock_with :mocha
  config.include(ConfigurationGlobals)
end
