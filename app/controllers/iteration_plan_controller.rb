class IterationPlanController < ApplicationController
  def show
    account_name = Gitpit::PivotalTracker.account_names.detect { |name| name.to_slug.to_s == params[:account_name] }
    @overall_velocity = Gitpit::PivotalTracker.overall_velocity(account_name)
    @current_stories = Gitpit::PivotalTracker.current_stories(account_name)
    @backlog_stories = Gitpit::PivotalTracker.backlog_stories(account_name)
  end
end
