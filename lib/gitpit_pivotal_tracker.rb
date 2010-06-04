# encoding: utf-8

module GitPit
  module RealPivotalTracker
    def token=(value)
      ::PivotalTracker::Client.token = value
    end
    
    def login(username, password)
      ::PivotalTracker::Client.token(username, password)
    end
    
    def logout
      ::PivotalTracker::Client.token = nil
    end
    
    def account_names
      project_account_names = ::PivotalTracker::Project.all.map { |project| project.account }
      project_account_names.sort.uniq
    end    
  end
  
  module FakePivotalTracker
    
    def token=(value)
      @token = value
    end
    
    def login(username, password)
      @token = username
    end
    
    def logout
      @token = nil
    end
    
    def account_names
      []
    end
  end
  
  module PivotalTracker
    extend RealPivotalTracker
    
    def self.mode=(mode)
      extend FakePivotalTracker if mode == :test
    end
  end

end

