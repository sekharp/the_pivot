require 'test_helper'

class GuestViewsThreeTopProjectsOnHomepageTest < ActionDispatch::IntegrationTest
  test "guest sees three top projects on homepage" do
    visit "/"
    save_and_open_page
    assert page.has_content?("Featured Projects")
    assert page.has_content?("micro-lending platform")
  end
end
