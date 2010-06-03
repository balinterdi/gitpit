Given /^there is a PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  PivotalTracker::Client.stub!(:token).and_return("abcdef")
end

Given /^there is no PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  PivotalTracker::Client.stub!(:token).and_return(nil)
end

Given /^I have the following PT accounts: "([^\"]*)"$/ do |names|
  account_names = names.split(',')
  PivotalTracker::Project.stub!(:all).and_return(account_names.map do |name|
    project = PivotalTracker::Project.new
    project.account = name.strip
    project
  end)
end

Then /^I should see a link called "([^\"]*)"$/ do |name|
  page.should have_xpath("//a[text()='#{name}']")
end