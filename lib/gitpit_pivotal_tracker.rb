# encoding: utf-8

module GitPit
  module PivotalTracker
    def self.token=(value)
      ::PivotalTracker::Client.token = value
    end
    
    def self.login(username, password)
      ::PivotalTracker::Client.token(username, password)
    end
    
    def self.logout
      ::PivotalTracker::Client.token = nil
    end
    
    def self.account_names
      project_account_names = ::PivotalTracker::Project.all.map { |project| project.account }
      project_account_names.sort.uniq
    end
    
  end
  
end
