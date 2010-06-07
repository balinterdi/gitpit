require "gitpit"

Rails.configuration.middleware.use Warden::Manager do |manager|
  # sets up a warden strategy for PT
  # see http://wiki.github.com/hassox/warden/setup
  manager.default_strategies :pivotal
  manager.failure_app = Gitpit::FailureApp

  Warden::Strategies.add(:pivotal) do
    def valid?
      params["username"] && params["password"]
    end

    def authenticate!
      begin
        token = Gitpit::PivotalTracker.login(params["username"], params["password"])
        success!(token)
      rescue RestClient::Request::Unauthorized
        fail!("Could not login.")
      end
    end

  end

end
