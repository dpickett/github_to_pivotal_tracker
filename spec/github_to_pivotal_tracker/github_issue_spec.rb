require 'spec_helper'

describe GithubToPivotalTracker::GithubIssue do
  use_vcr_cassette "github/list_issues", :record => :new_episodes

  let(:issues) { GithubToPivotalTracker::GithubIssue.find(:repo => GITHUB_REPO, :user => GITHUB_REPO_USER) }
  
  it "finds issues" do
    issues.should_not be_empty
  end
  
  describe "an instance" do
    subject { issues.first }
    
    its(:body) { should_not be_nil }
    its(:title) { should_not be_nil }
    its(:milestone) { should_not be_nil }
    its(:labels) { should_be kind_of(Array) }
  end
end