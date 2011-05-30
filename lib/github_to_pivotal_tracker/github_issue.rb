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
    end
  end
end