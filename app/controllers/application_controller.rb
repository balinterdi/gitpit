class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'application'

  before_filter :authenticate_with_warden

  def authenticate_with_warden
    unless warden.authenticated?
      warden.authenticate!
    else
      Gitpit::PivotalTracker.token = warden.user
    end
  end

  def logged_in?
    warden.authenticated?
  end
  helper_method :logged_in?
  
  private
    def warden
      env['warden']
    end

end
