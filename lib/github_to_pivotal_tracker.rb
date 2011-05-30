require "httparty"
require "configatron"
require "github_to_pivotal_tracker/github_issue"

module GithubToPivotalTracker
  def self.github_user
    configuration[:github_user]
  end
  
  def self.github_user=(user)
    configuration[:github_user] = user
  end
  
  def self.github_password
    configuration[:github_password]
  end
  
  def self.github_password=(gh_password)
    configuration[:github_password] = gh_password
  end
  
  protected
  def self.configuration
    configatron.github_to_pivotal_tracker.to_hash
  end
end