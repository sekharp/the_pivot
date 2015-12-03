class Users::CartProjectsController < ApplicationController
  def new
    @project = Project.find(params[:project])
  end

  def create
    project_id = params[:cart_project][:project_id]
    amount = params[:cart_project][:amount].to_i
    @cart.add_project(project_id, amount)
    session[:cart] = @cart.contents

    redirect_to cart_index_path
  end
end
