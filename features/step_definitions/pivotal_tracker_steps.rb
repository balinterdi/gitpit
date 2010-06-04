Given /^there is a PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  GitPit::PivotalTracker.stub!(:login).and_return("abcdef")
end

Given /^there is no PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  GitPit::PivotalTracker.stub!(:login).and_return(nil)
end

Given /^I have the following PT accounts: "([^\"]*)"$/ do |names|
  account_names = names.split(',').map { |account_name| account_name.strip }
  GitPit::PivotalTracker.stub!(:account_names).and_return(account_names)
end

Given /^I have no PT accounts$/ do
  GitPit::PivotalTracker.stub!(:account_names).and_return([])
end

Then /^I should see a link called "([^\"]*)"$/ do |name|
  page.should have_xpath("//a[text()='#{name}']")
end