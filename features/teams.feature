Feature: Teams

  Scenario: Creating and updating a team
    Given I have generated and unlocked my key
    And I follow "New Team"
    And I fill in "Name" with "GitHub"
    And I press "Create"
    Then I should see "GitHub" within the sidebar
    And I should see "GitHub" within the details

    When I follow "Edit" within the details
    And I fill in "Name" with "GitHub Staff"
    And I press "Save"
    Then I should see "GitHub Staff" within the sidebar
    And I should see "GitHub Staff" within the details

  Scenario: Adding a new user to a team
    Given I have generated and unlocked my key
    And I create a team named "GitHub"

    When I follow "GitHub"
    And I fill in "Email" with "shawn@example.com"
    And I press "Invite"

    Then I should see "shawn@example.com" within the team members
    And "shawn@example.com" should receive an email

    When I sign out
    And I open the email
    And I click the first link in the email
    And I generate a key

    Then I should see "GitHub"
    And I should see "waiting for Brandon Keepers to sign in"

