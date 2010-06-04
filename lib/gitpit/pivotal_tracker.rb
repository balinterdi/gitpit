# encoding: utf-8

module Gitpit
  module PivotalTracker
    module Test

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

    module Production
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
          projects.select { |project| project.account.to_slug == account }.inject(0) do |velocity, project|
          velocity + project.current_velocity.to_i
        end
      end
    end

    def self.mode=(mode)
      extend Test if mode == :test
      extend Production if mode == :production
    end

    # production by default
    self.mode = :production
  end

end
