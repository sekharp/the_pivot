require 'test_helper'

class GuestCanAddAProjectToTheirCartTest < ActionDispatch::IntegrationTest
  test "guest can add a project to their cart" do
    borrower = create_borrower
    borrower.projects << create_project

    visit "/"
    click_button "Learn More"

    assert_equal "/john-doe/projects/buy-me-a-goat", current_path
    within(".lend-btn") do
      click_link "Lend"
    end

    assert_equal "/john-doe/cart_projects/new", current_path

    fill_in "Amount", with: "100"

    within(".lend-form") do
      click_button "Lend!"
    end

    within "#primary-navigation" do
      assert page.has_content? "1"
    end
    assert_equal "/projects", current_path
  end

  def create_borrower
    User.create!(first_name: "John",
                 last_name: "Doe",
                 username: "jdoe",
                 password: "password")
  end

  def create_project
    Project.create!(goal_amount: 1000,
                    title: "Buy me a goat",
                    description: "Mostly goat purchases")
  end
end
