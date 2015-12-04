class Users::CartProjectsController < ApplicationController
  def new
    @project = Project.find(params[:project])
  end

  def create
    project = Project.find(params[:cart_project][:project_id])
    amount = params[:cart_project][:amount].to_f

    if valid_amount?(amount, project)
      @cart.add_project(project.id, amount)
      session[:cart] = @cart.contents

      flash[:success] = "Added #{view_context.link_to "#{project.title}", user_project_path(user: project.user.slug, id: project.slug)} loan to your cart.".html_safe
      redirect_to cart_index_path
    else
      flash[:error] = "Please enter a valid amount"
      redirect_to new_user_cart_project_path(user: project.user.slug, project: project)
    end
  end
end
