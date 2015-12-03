class Users::CartProjectsController < ApplicationController
  def new
    @project = Project.find(params[:project])
  end

  def create
    project = Project.find(params[:cart_project][:project_id])
    amount = params[:cart_project][:amount].to_i

    @cart.add_project(project.id, amount)
    session[:cart] = @cart.contents

    flash[:success] = "Added #{view_context.link_to "#{project.title}", project_path(project.id)} loan to your cart.".html_safe
    redirect_to cart_index_path
  end
end
