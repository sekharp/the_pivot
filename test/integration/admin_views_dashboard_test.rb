require 'test_helper'

class AdminViewsDashboardTest < ActionDispatch::IntegrationTest
  test "admin can view the admin dashboard" do
    create_admin
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit admin_dashboard_path(id: current_user.id)
    assert page.has_content?("Admin Dashboard")
  end

  test "registered user sees 404 at admin dashboard" do
    create_lender
    login_lender

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit admin_dashboard_index_path
    refute page.has_content?("Admin Dashboard")
    assert page.has_content?("404")
  end

  test "guest sees a 404 at admin dashboard" do
    visit admin_dashboard_index_path
    refute page.has_content?("Admin Dashboard")
    assert page.has_content?("404")
  end
end
