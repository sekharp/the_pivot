require 'test_helper'

class RegisteredBorrowerCreatesProjectTest < ActionDispatch::IntegrationTest
  test "registered borrower creates a project" do
    create_roles
    create_borrower
    visit "/"
    click_link "Login"
    within(".login-form") do
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"
    end

    assert_equal "/borrower_dashboard", current_path
    click_button "Create A New Project"
  end
end
