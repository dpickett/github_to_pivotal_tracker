require 'vcr'

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir = File.dirname(__FILE__) + '/../cassettes'
  c.filter_sensitive_data('<GH_USER>') { GithubToPivotalTracker.github_user }
  c.filter_sensitive_data('<GH_PASSWORD>') { GithubToPivotalTracker.github_password }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end