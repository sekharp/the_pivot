class ProjectsController < ApplicationController
  def index
    if params.include?("category_id")
      @category = Category.find(params[:category_id])
      @projects = @category.projects.all
    else
      @projects = Project.all
    end
  end

  def show
    @projects = Project.find(params[:id].to_i)
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    if @project.save
      flash[:success] = "#{@project.title} saved"
      redirect_to admin_projects_path
    else
      flash[:error] = "Something went wrong. Try again."
      render :edit
    end
  end

  private

  def project_params
    params.require(:sticker).permit(:title,
                                    :description,
                                    :goal_amount,
                                    :image_file_name,
                                    :retired)
  end
end
