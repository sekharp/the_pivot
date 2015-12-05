require 'test_helper'

class ProjectImageLinksToProjectTest < ActionDispatch::IntegrationTest
  test "project image links to project path" do
    borrower = create_borrower
    borrower.projects << create_project
    visit "/"

    first('.card').find("img[id='project-image']").click
    assert_equal "/john-doe/projects/buy-me-a-goat", current_path
  end
end
