require 'test_helper'

class GuestCanViewProjectsIndexTest < ActionDispatch::IntegrationTest
  test "guest can view projects index" do
    create_project
    visit "/"
    click_link("Lend")

    assert_equal "/projects", current_path
    assert page.has_content?("Buy me a goat")
  end

  def create_project
    Project.create!(
                    borrower_id: 1,
                    goal_amount: 1000,
                    title: "Buy me a goat",
                    description: "Mostly goat purchases"
    )
  end
end
