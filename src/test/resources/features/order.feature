Feature: Happy case order placement

Background:
  * def users = read('classpath:data/users.json')

Scenario Outline: Place an order with valid credentials
  * def baseUrl = karate.get('baseUrl')
  * def user = users[<index>]
  * print 'Running test with user:', user
  * if (!user || !user.username) karate.fail('>>> Missing user in ORDER: ' + user)
  * call read('classpath:pages/LoginPage.feature') { user: #(user), baseUrl: #(baseUrl) }
  * call read('classpath:pages/ProductPage.feature')
  * call read('classpath:pages/CartPage.feature')
  * call read('classpath:pages/CheckoutPage.feature') { user: #(user) }
  * call read('classpath:pages/ConfirmationPage.feature')


Examples:
  | index |
  | 0     |
  | 1     |
  | 2     |

@AfterScenario
Scenario: Cleanup after test
  * if (typeof driver !== 'undefined') karate.log('Closing driver...') && driver.quit()

