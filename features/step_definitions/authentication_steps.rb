Given /^I am logged in as "([^\"]*)"$/ do |username|
  Given %(there is a PT profile with username: "#{username}", password: "secret")
  When %(I go to the home page)
  And %(I fill in "Username" with "#{username}")
  And %(I fill in "Password" with "secret")
  And %(I press "Login")
end
