require 'test_helper'

class RegisteredBorrowerLogsInTest < ActionDispatch::IntegrationTest
  test "borrower can login" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/borrower_dashboard", current_path
    within("#primary-navigation") do
      refute page.has_content?("Login")
      assert page.has_content?("Logout")
    end
  end

  test "logged in borrower sees project details" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/borrower_dashboard", current_path
    assert page.has_content?("Your Current Projects")
    assert page.has_content?("Project Title: Buy me a goat")
    assert page.has_content?("Goal Amount: $1000")
    assert page.has_content?("Total Loans Made: $0")
    assert page.has_content?("Percent Funded: 0%")
  end

  test "borrowers percent funded increases" do
    skip
  end

  test "borrower dashboard displays approved, pending, completed and canceled projects" do
    skip
  end

  test "borrower dashboard displays bio and profile picture" do
    skip
  end
end
