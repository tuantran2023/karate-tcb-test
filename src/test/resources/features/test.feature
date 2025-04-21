Feature: Test Firefox Launch

Scenario: Launch Firefox
  * def browser = karate.get('browser')
  * def baseUrl = karate.get('baseUrl')
  * print '===================  BROWSER: ', browser
  * print '===================  BASE URL: ', baseUrl
  * driver baseUrl

  * def user = { username: 'standard_user', password: 'secret_sauce' }
  * print 'Running test with user:', user
  * if (!user || !user.username) karate.fail('>>> Missing user in ORDER: ' + user)

  * call read('classpath:pages/LoginPage.feature') { user: #(user), config: { baseUrl: #(baseUrl), browser: #(browser) } }
