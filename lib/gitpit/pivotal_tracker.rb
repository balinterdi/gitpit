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

        def projects
          []
        end
      end
      
    end

    class Production
      class << self
        def token=(value)
          ::PivotalTracker::Client.token = value
        end

        def login(username, password)
          ::PivotalTracker::Client.token(username, password)
        end

        def logout
          ::PivotalTracker::Client.token = nil
        end

        def projects
          ::PivotalTracker::Project.all
        end

        def account_names
          project_account_names = projects.map { |project| project.account }
          project_account_names.sort.uniq
        end

        def overall_velocity(account)
          projects.select { |project| project.account.to_slug == account.to_slug }.inject(0) do |velocity, project|
            velocity + project.current_velocity.to_i
          end
        end

        def current_stories(account)
          projects.collect { |project| project.iteration(:current).stories }.flatten
        end
      end
      
    end

    cattr_accessor :mode
    
    def self.method_missing(method, *args, &block)
      "Gitpit::PivotalTracker::#{@@mode.to_s.capitalize}".constantize.send(method, *args, &block)
    end
    
    self.mode = :production
  end

end
