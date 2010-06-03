require 'gitpit_authentication'
require "gitpit_pivotal_tracker"

Rails.configuration.middleware.use Warden::Manager do |manager|
  # sets up a warden strategy for PT
  # see http://wiki.github.com/hassox/warden/setup
  manager.default_strategies :pivotal
  manager.failure_app = GitPit::FailureApp

  Warden::Strategies.add(:pivotal) do
    def valid?
      params["username"] && params["password"]
    end

    def authenticate!
      begin
        token = GitPit::PivotalTracker.login(params["username"], params["password"])
        success!(token)
      rescue RestClient::Request::Unauthorized
        fail!("Could not login.")
      end
    end

  end

end
