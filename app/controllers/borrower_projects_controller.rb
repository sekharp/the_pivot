class BorrowerProjectsController < ApplicationController
  def new
    @project = Project.new
    @categories = Category.all
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      current_user.projects << @project
      redirect_to borrower_dashboard_path
    else
      flash.now[:error] = "Something went wrong. Make sure you fill out all fields."
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:title,
                                    :goal_amount,
                                    :description,
                                    )
  end
end
