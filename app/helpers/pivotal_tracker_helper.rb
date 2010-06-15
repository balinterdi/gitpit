module PivotalTrackerHelper
  def project_name_for(story)
    project = Gitpit::PivotalTracker.project_for_story(story)
    link_to(project.name, "http://www.pivotaltracker.com/projects/#{project.id}", :target => "_blank") if project
  end

  def project_color_for(story)
    project = Gitpit::PivotalTracker.project_for_story(story)
    Gitpit::PivotalTracker.all_projects.index(project)
  end

end