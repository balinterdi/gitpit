class HomeController < ApplicationController

  skip_before_filter :authenticate_with_warden, :only => [:index]

  def index
    redirect_to dashboard_path if logged_in?
  end
  
  def dashboard
    @account_names = GitPit::PivotalTracker.account_names
  end
  
end
