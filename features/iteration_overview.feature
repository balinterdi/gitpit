@http://www.pivotaltracker.com/story/show/3770072
Feature: Iteration overview
  In order to see an aggregated overview of the current iteration
  As a user
  I want see an overview of all projects of one of my accounts

  Scenario: User with active projects goes to the dashboard
    Given I have the following PT accounts:
      | name |
      | Secret Sauce Partners |
      | Pet Projects |
    And I am logged in as "veronica"
    When I go to the dashboard
    Then I should see a link called "Secret Sauce Partners"
    And I should see a link called "Pet Projects"

  Scenario: User with no accounts goes to the dashboard
    Given I have no PT accounts
    And I am logged in as "veronica"
    When I go to the dashboard
    Then I should see "No account with active projects available"

  Scenario: User checks out iteration overview
    Given I have the following PT accounts:
      | name | overall_velocity |
      | Secret Sauce Partners | 12 |
    And I am logged in as "veronica"
    When I go to the dashboard
    And I follow "Secret Sauce Partners"
    Then I should see "12" as the overall velocity
@wip
  Scenario: User sees the list of stories in the current iteration
    Given I have the following PT stories:
      | account | project | name | iteration |
      | SSP | GitPit | Authentication | done |
      | SSP | GitPit | Iteration overview | current |
      | SSP | GitPit | Remember me | backlog |
      | SSP | Operations | Take out the trash | current |
      | Pet Projects | The next big thing | Brainstorming | current |
    And I am logged in as "veronica"
    When I go to the dashboard
    And I follow "SSP"
    Then I should see "Iteration overview" in the current iteration panel
    And I should see "Take out the trash" in the current iteration panel
    But I should not see "Remember me" in the current iteration panel
    And I should not see "Brainstorming" in the current iteration panel
  
  
  
    