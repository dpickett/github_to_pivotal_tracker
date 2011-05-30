module GithubToPivotalTracker
  class GithubIssue
    include HTTParty
    attr_accessor :state, :number, :labels, :body, :title, :milestone, :url, :updated_at, :created_at, :html_url
    base_uri 'https://api.github.com'

    def initialize(attributes = {})
      attributes.each do |attribute, value|
        setter = "#{attribute}="
        if self.respond_to?(setter)
          self.send(setter, value)
        end
      end
      
      labels ||= []
    end
    
    def to_pivotal_tracker_story
      labels_to_send = labels.map{|i| i["name"]} || []
      labels_to_send += ["milestone_#{milestone['title']}"] if !milestone.nil? && milestone != {}
      GithubToPivotalTracker::PivotalTrackerStory.new({
        :name => title,
        :description => body,
        :labels => labels_to_send
      })
    end
    
    class << self
      def find(options = {})
        user, repo = options.delete(:user), options.delete(:repo)
        actual_options = {}
        actual_options[:query] = options
        actual_options[:basic_auth] = {:username => GithubToPivotalTracker.github_user, :password => GithubToPivotalTracker.github_password }
        
        response = get("/repos/#{user}/#{repo}/issues", actual_options)
        
        #TODO - handle for exceptional cases
        response ||= []
        response.map do |issue_hash|
          new(issue_hash)
        end
      end
      
      def export_open(options = {})
        pivotal_project_id = options[:pivotal_project]
        find({:state => "open", :per_page => 100}.merge(options)).each do |issue| 
          story = issue.to_pivotal_tracker_story 
          story.project_id = pivotal_project_id
          story.save
        end
      end
    end
  end
end