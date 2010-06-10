# encoding: utf-8

module Gitpit
  class PivotalTracker
    class Test
      class << self
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

        def projects(account=:all)
          []
        end
        
        def overall_velocity(account=:all)
          0
        end
        
        def current_stories(account=:all)
          []
        end
        
        def backlog_stories(account=:all)
          []
        end
      end
    end

    class Production
      class << self
        extend ActiveSupport::Memoizable
        
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
          project_account_names = projects.map { |project| project.account }
          project_account_names.sort.uniq
        end

        def projects(account = :all)
          if account == :all
            all_projects
          else
            all_projects.select { |project| project.account == account }
          end
        end

        def project(project_id)
          ::PivotalTracker::Project.find(project_id)
        end
        memoize :project

        def overall_velocity(account=:all)
          projects(account).inject(0) do |velocity, project|
            velocity + project.current_velocity.to_i
          end
        end

        def current_stories(account=:all)
          projects(account).collect { |project| project.iteration(:current).stories }.flatten
        end

        def backlog_stories(account=:all)
          projects(account).collect { |project| project.iteration(:backlog).collect { |iteration| iteration.stories}.flatten }.flatten
        end

        private

        def all_projects
          ::PivotalTracker::Project.all
        end
        memoize :all_projects
        
      end
      
    end

    cattr_accessor :mode
    
    def self.method_missing(method, *args, &block)
      _module = "Gitpit::PivotalTracker::#{@@mode.to_s.capitalize}".constantize
      _module.send(method, *args, &block)
    end
    
    self.mode = :production
  end

end
