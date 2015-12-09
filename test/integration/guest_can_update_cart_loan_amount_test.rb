require 'test_helper'

class GuestCanUpdateCartLoanAmountTest < ActionDispatch::IntegrationTest
  test 'guest can update cart loan amount' do
    borrower = create_borrower
    project = create_project
    borrower.projects << project
    add_project_to_cart(project)

    visit '/cart'
    within '#Buy me a goat-button' do
      assert page.has_content? '$200.00'
    end

    within '.update-amount' do
      fill_in 'Amount', with: 100
      click_button 'Update'
    end

    assert_equal '/cart', current_path

    within '#Buy me a goat-button' do
      assert page.has_content? '$100.00'
    end
  end
end

