require 'test_helper'

class GuestViewsThreeTopProjectsOnHomepageTest < ActionDispatch::IntegrationTest
  test "guest sees three top projects on homepage" do
    borrower = create_borrower
    test_projects = create_projects(6)
    
    borrower.projects << test_projects

    assert_equal 6, borrower.projects.count
    visit "/"

    assert page.has_content?("Featured Projects")
    assert page.has_content?("Project # 1")
    assert page.has_content?("Project # 2")
    assert page.has_content?("Project # 3")
    assert page.has_content?("micro-lending platform")
  end
end
