Feature: Products Page

* def txtUserName = "//input[@data-test='username']"
* def txtPassword = "//input[@data-test='password']"
* def btnLogin = "#login-button']"

Scenario: Add product to cart
  * click('button.btn_primary.btn_inventory')
  * click('.shopping_cart_link')
  * waitFor('#cart_contents_container')
