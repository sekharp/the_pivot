require 'test_helper'

class UserDashboardTest < ActionDispatch::IntegrationTest
  test "authenticated lender routed to lender dashboard from login" do
    create_borrower_projects_and_lender
    visit root_path
    click_link "Login"
    fill_in "Username", with: "matt"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path
  end

  test "authenticated lender sees loan history on dashboard" do
    skip
    create_borrower_projects_and_lender
    visit root_path
    click_link "Login"
    fill_in "Username", with: "matt"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path
    assert page.has_content?("Past Loans")
  end
end
