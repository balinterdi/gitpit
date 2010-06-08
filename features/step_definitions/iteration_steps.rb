Then /^I should see "([^\"]*)" as the overall velocity$/ do |velocity|
  page.find(:xpath, "//p[@class='velocity']").text.should include(velocity)
end

Then /^I should see "([^\"]*)" in the current iteration panel$/ do |story_name|
  page.find(:xpath, "//div[@id='current-iteration-panel']").text.should include(story_name)
end

Then /^I should not see "([^\"]*)" in the current iteration panel$/ do |story_name|
  page.find(:xpath, "//div[@id='current-iteration-panel']").text.should_not include(story_name)
end
