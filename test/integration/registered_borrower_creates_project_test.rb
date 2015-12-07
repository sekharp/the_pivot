require 'test_helper'

class RegisteredBorrowerCreatesProjectTest < ActionDispatch::IntegrationTest
  test "registered borrower creates a project" do
    create_borrower
    visit "/"
    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_link  
  end
end
