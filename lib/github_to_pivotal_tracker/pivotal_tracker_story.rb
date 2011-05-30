module GithubToPivotalTracker
  class PivotalTrackerStory
    attr_accessor :name, :description, :labels, :project_id
    include HTTParty
    base_uri "https://www.pivotaltracker.com/services/v3/"
    
    def initialize(attributes = {})
      attributes.each do |attribute, value|
        setter = "#{attribute}="
        if self.respond_to?(setter)
          self.send(setter, value)
        end
      end
    end
    
    def save
      options = {}
      options[:query] = to_query
      options[:headers] = {}
      options[:headers]["X-TrackerToken"] = GithubToPivotalTracker.pivotal_token
      
      self.class.post("/projects/#{self.project_id}/stories", options)
    end
    
    def to_query
      query_hash = {}
      [
        :name,
        :description
      ].each do |item|
        query_hash["story[#{item}]"] = self.send(item)
      end
      
      query_hash["story[labels]"] = self.labels.join(",")
      
      query_hash
    end
    
    def builder
      Nokogiri::XML::Builder
    end
  end
end