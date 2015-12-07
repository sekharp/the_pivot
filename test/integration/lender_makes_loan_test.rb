require 'test_helper'

class LenderMakesLoanTest < ActionDispatch::IntegrationTest
  test 'lender makes loan' do
    create_roles
    borrower = create_borrower
    project = create_project
    borrower.projects << project
    add_project_to_cart(project)

    lender = create_lender
    login_lender

    visit '/cart'
    click_button 'Checkout'

    assert_equal '/lender_dashboard', current_path
    assert lender.loans.count == 1

    within '#primary-navigation' do
      assert page.has_content? '0'
    end

    within '#nav-bar' do
      assert page.has_content? 'Loan submitted'
    end
  end
end
