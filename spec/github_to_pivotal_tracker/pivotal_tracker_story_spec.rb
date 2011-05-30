require 'spec_helper'

describe GithubToPivotalTracker::PivotalTrackerStory do
  use_vcr_cassette "pivotal_tracker/save_story", :record => :new_episodes

  subject { GithubToPivotalTracker::PivotalTrackerStory.new(:name => "something worth doing", :description => "trust me it's a good feature", :labels => ["foo", "bar"], :project_id => PT_PROJECT)}
  
  it "saves a story" do
    subject.save.should be_true
  end
end