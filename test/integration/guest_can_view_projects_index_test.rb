require 'test_helper'

class GuestCanViewProjectsIndexTest < ActionDispatch::IntegrationTest
  test "guest can view projects index" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project

    visit "/"
    within "#primary-navigation" do
      click_link("Lend")
    end

    assert_equal "/projects", current_path
    assert page.has_content?("Buy me a goat")
  end
end
