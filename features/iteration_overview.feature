@http://www.pivotaltracker.com/story/show/3770072
Feature: Iteration overview
  In order to see an aggregated overview of the current iteration
  As a user
  I want see an overview of all projects of one of my accounts

  Scenario: User with active projects goes to the dashboard
    Given I have the following PT accounts: "Secret Sauce Partners, Pet Projects"
    And I am logged in as "veronica"
    When I go to the dashboard
    Then I should see a link called "Secret Sauce Partners"
    And I should see a link called "Pet Projects"

  Scenario: User with no accounts goes to the dashboard
    Given I have no PT accounts
    And I am logged in as "veronica"
    When I go to the dashboard
    Then I should see "No account with active projects available"
@wip
  Scenario: User checks out iteration overview
    Given I have the following PT projects:
      | name | account | current_velocity |
      | GitPit | Secret Sauce Partners | 5 |
      | Operations | Secret Sauce Partners | 7 |
      | The next big thing | Pet Projects | 1 |
    And I am logged in as "veronica"
    When I go to the dashboard
    And I follow "Secret Sauce Partners"
    Then I should see "12" as the overall velocity


