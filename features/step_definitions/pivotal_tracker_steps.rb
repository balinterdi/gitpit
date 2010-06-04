Given /^there is a PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  Gitpit::PivotalTracker.stub!(:login).and_return("abcdef")
end

Given /^there is no PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  Gitpit::PivotalTracker.stub!(:login).and_return(nil)
end

Given /^I have the following PT accounts: "([^\"]*)"$/ do |names|
  account_names = names.split(',').map { |account_name| account_name.strip }
  Gitpit::PivotalTracker.stub!(:account_names).and_return(account_names)
end

Given /^I have no PT accounts$/ do
  Gitpit::PivotalTracker.stub!(:account_names).and_return([])
end

Given /^I have the following PT projects:$/ do |table|
  projects = table.hashes.map do |hash|
    project = PivotalTracker::Project.new
    hash.each do |attribute, value|
      project.send("#{attribute}=", value)
    end
    project
  end

  Gitpit::PivotalTracker.stub!(:projects).and_return(projects)
end

Then /^I should see a link called "([^\"]*)"$/ do |name|
  page.should have_xpath("//a[text()='#{name}']")
end