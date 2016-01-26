@my_vw @Login-2
Feature: My VW Login Version 2
  As the owner of the new My Volkswagen login section
  We need to ensure that existing and new users can access the login form
  And that the relevant security measures work as expected

  Background: Visiting the Login Page
    Given i am on the My VW Login Page

  @login @clear_cookies
  Scenario: Logging in with a validated account
    When i enter my registered account email address
    And i enter my accounts correct password
    And i submit my attempt to login
    Then i should be logged into the My Volkswagen section

  Scenario: Attempted Login with missing details
    When i enter the random unregistered email address "boxyboxyboxy@example.com"
    And i enter a random valid password for this account
    And i submit my attempt to login
    Then i should see a login error appear in my browser:
    """
    Your email and/or password are incorrect. Please try again
    """

#  *****Please note this step is currently in pending state - depending on ticket VWBS-1159*****
#
#  @Register_temp_2
#  Scenario Outline: Attempted Incorrect Password Login to a registered account
#    Given i have previously submitted <number> invalid logins
#    When i enter my registered account email address
#    And i enter a random valid password for this account
#    And i submit my attempt to login
#    Then i should see this error message for <number> incorrect login attempts:
#    | Feedback                                                                                                       |
#    | Sorry your login doesnt match our data. You have 4 more attempts before your account is locked for 30 minutes. |
#    | Sorry your login doesnt match our data. You have 3 more attempts before your account is locked for 30 minutes. |
#    | Sorry your login doesnt match our data. You have 2 more attempts before your account is locked for 30 minutes. |
#    | Sorry your login doesnt match our data. You have 1 more attempts before your account is locked for 30 minutes. |
#
#    Examples:
#    | number |
#    |   0    |
#    |   1    |
#    |   2    |
#    |   3    |

#  @Register_temp_2
#  Scenario: Account lockout after 5 incorrect password attempts
#    Given i have previously submitted 4 invalid logins
#    When i enter my registered account email address
#    And i enter a random valid password for this account
#    And i submit my attempt to login
#    Then i should see an error page in my browser informing me that my account is locked
#    And there should be a button to reset my existing password

  @login @clear_cookies
  Scenario: Login with remember me set
    Given i enter my registered account email address
    And i enter my accounts correct password
    When i check the Remember me box on the login form
    And i submit my attempt to login
    Then i should be logged into the My Volkswagen section
    And the remember me cookie should be set in my browser

  Scenario: Link to reset my password
    When i click on the link to go to the reset password form
    Then i should see the forgot password form load in my browser

  Scenario: Link to register a new account
    When i click on the link to go to the registration page
    Then i should see the registration form load in my browser

  @clear_cookies @login
  Scenario: Logging out from my account
    Given i enter my registered account email address
    And i enter my accounts correct password
    When i submit my attempt to login
    But i then log out from my Volkswagen account
    Then i should find i am no longer signed into my account

#   *****Not yet implemented*****
#  Scenario Outline: Email field format is not correct
#    Given i have filled in my email <email>
#    When i press login but the validation is not met
#    Then i should get the following error message displayed:
#    """
#    Please provide a valid email address
#    """
#
#  Examples:
#  | email             |
#  | tester.com        |
#  | tester@com        |
#  | **//@test.com     |
#  | 123@**//.com      |
#  | @@                |
#  | tester@com        |
#  | tester@com@       |
#  | tester.com@       |

