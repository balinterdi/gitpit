Then /^I should see "([^\"]*)" as the overall velocity$/ do |velocity|
  page.find(:xpath, "//p[@class='velocity']").text.should include(velocity)
end
