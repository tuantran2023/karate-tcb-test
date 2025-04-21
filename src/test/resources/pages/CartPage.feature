Feature: Cart Page

Background:
  * def txtUserName = "//input[@data-test='username']"
  * def txtPassword = "//input[@data-test='password']"
  * def btnCheckout = "#login-button']"

Scenario: Go to checkout
  * click('.checkout_button')
  * waitFor('#checkout_info_container')
