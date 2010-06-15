Then /^I should see "([^\"]*)" as the overall velocity$/ do |velocity|
  page.find(:xpath, "//li[@class='caption']").text.should include(velocity)
end

Transform /^(current iteration|backlog) panel$/ do |group_arg|
  group_arg.gsub(" ", "-")
end

Then /^I should see "([^\"]*)" in the ((?:current iteration|backlog) panel)$/ do |story_name, group|
  page.find(:xpath, "//section[@id='#{group}-panel']").text.should include(story_name)
end

Then /^I should not see "([^\"]*)" in the ((?:current iteration|backlog) panel)$/ do |story_name, group|
  page.find(:xpath, "//section[@id='#{group}-panel']").text.should_not include(story_name)
end
