Feature: Products Page

Scenario: Add product to cart
  * click('button.btn_primary.btn_inventory')
  * click('.shopping_cart_link')
  * waitFor('#cart_contents_container')
