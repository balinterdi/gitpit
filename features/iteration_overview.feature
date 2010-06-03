@http://www.pivotaltracker.com/story/show/3770072
@wip
Feature: Iteration overview
  In order to see an aggregated overview of the current iteration
  As a user
  I want see an overview of all projects of one of my accounts

  Scenario: See a list of accounts on the home page
    Given I have the following PT accounts: "Secret Sauce Partners, Pet Projects"
    And I am logged in as "veronica"
    When I go to the home page
    Then I should see a link called "Secret Sauce Partners"
    And I should see a link called "Pet Projects"

