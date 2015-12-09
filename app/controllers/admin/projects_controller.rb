class Admin::ProjectsController < Admin::BaseController
  def update
    project = Project.find(params[:id])
    project.update(:status => params[:status])
    redirect_to admin_dashboard_index_path
  end
end
