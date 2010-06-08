Given /^there is a PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  Gitpit::PivotalTracker.stub!(:login).and_return("abcdef")
end

Given /^there is no PT profile with username: "([^\"]*)", password: "([^\"]*)"$/ do |username, password|
  Gitpit::PivotalTracker.stub!(:login).and_return(nil)
end

Given /^I have the following PT accounts:$/ do |table|
  accounts = {}
  table.hashes.each do |hash|
    accounts[hash["name"]] ||= {}
    if ( velocity = hash["overall_velocity"] )
      accounts[hash["name"]]["overall_velocity"] = velocity
    end
  end
  Gitpit::PivotalTracker.stub!(:account_names).and_return(accounts.keys)
  
  accounts.each do |account_name, account_data|
    if account_data["overall_velocity"]
      Gitpit::PivotalTracker.should_receive(:overall_velocity).with(account_name).and_return(account_data["overall_velocity"])
    end
  end
end

Given /^I have no PT accounts$/ do
  Gitpit::PivotalTracker.stub!(:account_names).and_return([])
end

Then /^I should see a link called "([^\"]*)"$/ do |name|
  page.should have_xpath("//a[text()='#{name}']")
end