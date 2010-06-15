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

Transform /^(current iteration|backlog)$/ do |group_arg|
  group_arg.gsub(" ", "_").to_sym
end

Given /^I have the following PT stories for the (current iteration|backlog) under the "([^\"]*)" account:$/ do |group, account, table|
  group_stories_method = group == :current_iteration ? :current_stories : :backlog_stories
  Gitpit::PivotalTracker.should_receive(group_stories_method).with(account).any_number_of_times.and_return(table.hashes.map { |hash| Factory.build(:story, hash) })
end

