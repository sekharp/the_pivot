class Users::ProjectsController < ApplicationController
  def show
    @project = Project.find_by_slug(params[:id])
    # @cart_project = CartProject.new(@project)
  end
end
