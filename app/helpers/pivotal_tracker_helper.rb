module PivotalTrackerHelper
  def project_name_for(args={})
    if project = Gitpit::PivotalTracker.project(args[:story].project_id)
      link_to(project.name, "http://www.pivotaltracker.com/projects/#{project.id}", :target => "_blank")
    end
  end
end