Then /^I should see a confirmation message$/ do
  page.should have_css("div#flash div.notice")
end

Then /^I should see an error message$/ do
  page.should have_css("div#flash div.alert")
end

Then /^I should see a link called "([^\"]*)"$/ do |name|
  page.should have_xpath("//a[text()='#{name}']")
end
