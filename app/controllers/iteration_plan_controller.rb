class IterationPlanController < ApplicationController
  def show
    @overall_velocity = Gitpit::PivotalTracker::overall_velocity(params[:account_name])
  end
end
