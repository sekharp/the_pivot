require 'test_helper'

class GuestCanCreateBorrowerAccountTest < ActionDispatch::IntegrationTest
  test 'guest can view create acount type page' do
    visit '/'
    within '#primary-navigation' do
      click_link 'Create Account'
    end

    within '.account-types' do
      assert page.has_css? '.lender-btn', 'Create Lender Account'
      assert page.has_css? '.borrower-btn', 'Create Borrower Account'
    end
  end
end
