Given /^there is a PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  Gitpit::PivotalTracker.stub!(:login).and_return("abcdef")
end

Given /^there is no PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  Gitpit::PivotalTracker.stub!(:login).and_return(nil)
end

Given /^I have the following PT accounts:$/ do |table|
  Gitpit::PivotalTracker.stub!(:account_names).and_return(table.hashes.map { |hash| hash[:name] })

  if table.headers.include? "overall_velocity"
    table.map_column!("overall_velocity") { |velocity| velocity.to_i }
    table.hashes.each do |hash|
      Gitpit::PivotalTracker.should_receive(:overall_velocity).with(hash[:name]).and_return(hash[:overall_velocity])
    end
  end
end

Given /^I have no PT accounts$/ do
  Gitpit::PivotalTracker.stub!(:account_names).and_return([])
end

Then /^I should see a link called "([^\"]*)"$/ do |name|
  page.should have_xpath("//a[text()='#{name}']")
end