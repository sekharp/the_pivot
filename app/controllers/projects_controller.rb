class ProjectsController < ApplicationController
  def index
    if params.include?("category_id")
      @category = Category.find(params[:category_id])
      @projects = @category.projects.all
    else
      @projects = Project.all
    end
  end


  private

  def project_params
    params.require(:project).permit(:title,
                                    :description,
                                    :goal_amount,
                                    :image)
  end
end
