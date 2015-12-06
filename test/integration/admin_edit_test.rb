require "test_helper"

class AdminEditProjectTest < ActionDispatch::IntegrationTest
  def setup
    create_roles_borrower_project_and_lender
    create_admin
    login_admin
  end

  # test "admin can view edit path" do
  #   visit admin_projects_path
  #   project = Project.last
  #   click_link "Edit"
  #
  #   assert edit_admin_project_path(project.id), current_path
  #
  #   within("#edit-project") do
  #     assert page.has_content?("Title")
  #     assert "New project", find_field("Title").value
  #     assert page.has_content?("Category")
  #     assert "Ruby", find_field("Category").value
  #     assert page.has_content?("Price")
  #     assert "5", find_field("Price").value
  #   end
  #
  #   fill_in "Description", with: "Edited project"
  #   click_button "Update project"
  #
  #   assert admin_projects_path, current_path
  #
  #   assert page.has_content?("Edited project")
  # end

  test "admin can edit project status" do
    skip
    visit admin_projects_path
    click_link "Edit"

    choose("approve-project")
    click_button "Update project"

    assert admin_projects_path, current_path

    click_link "Edit"

    within("#edit-project") do
      assert page.has_content?("Approved")
    end
  end
end
