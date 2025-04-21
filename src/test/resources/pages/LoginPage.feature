Feature: Login Page

Background:
  * def user = karate.get('user')
  * def baseUrl = karate.get('baseUrl')

  * def txtUserName = "//input[@data-test='username']"
  * def txtPassword = "//input[@data-test='password']"
  * def btnLogin = "#login-button']"

Scenario: Login with valid credentials
  
  * if (!user || !user.username) karate.fail('>>> Missing user in LOGIN: ' + user)
  # Launch the app
  * driver baseUrl

  # Perform login
  * waitFor('#user-name')
  * input('#user-name', user.username)
  * input('#password', user.password)
  * click('#login-button')
  * waitFor('#inventory_container')
