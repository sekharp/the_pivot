class Admin::DashboardController < Admin::BaseController
  def index
    @pending_projects = Project.where(status: "pending")
  end

  def show
    @admin = current_user
  end
end
