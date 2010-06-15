class SessionController < ApplicationController

  skip_before_filter :authenticate_with_warden, :only => [:create]

  def create
    if warden.authenticate!
      store_user_handle(params[:username])
      redirect_to dashboard_path, :notice => "You are now logged in."
    end
  end

  def destroy
    warden.logout
    Gitpit::PivotalTracker.logout
    redirect_to root_path, :notice => "You have been logged out."
  end

  private
    def store_user_handle(handle)
      session[:user_handle] = handle
    end

end
