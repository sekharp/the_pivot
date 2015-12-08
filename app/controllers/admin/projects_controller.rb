class Admin::ProjectsController < Admin::BaseController
  def update
    project = Project.find(params[:id])
    project.update(:status => params[:status])
    if params[:source].nil?
      redirect_to admin_dashboard_index_path
    else
      redirect_to admin_dashboard_path(id: current_user.id)
    end
  end
end
