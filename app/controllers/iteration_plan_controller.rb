class IterationPlanController < ApplicationController
  def show
    account_name = Gitpit::PivotalTracker.account_names.detect { |name| name.to_slug.to_s == params[:account_name] }
    @overall_velocity = Gitpit::PivotalTracker::overall_velocity(account_name)
  end
end
