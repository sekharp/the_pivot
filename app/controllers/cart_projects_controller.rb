class CartProjectsController < ApplicationController
  def create
    project = Project.find(params[:project_id])
    @cart.add_project(project.id)
    session[:cart] = @cart.contents
    flash[:success] = "Successfully added #{view_context.link_to "#{project.title}", project_path(project.id)} project to your cart.".html_safe
    redirect_to root_path
  end

  def update
    project = Sticker.find(params[:id])
    if params[:adjustment] == "increase"
      @cart.add_sticker(sticker.id)
      session[:cart] = @cart.contents
      flash[:success] = "Successfully added #{view_context.link_to "#{sticker.title}", sticker_path(sticker.id)} sticker to your cart.".html_safe
    else
      @cart.subtract_sticker(sticker.id)
      session[:cart] = @cart.contents
      flash[:success] = "Successfully removed one #{view_context.link_to "#{sticker.title}", sticker_path(sticker.id)} sticker from your cart.".html_safe
    end
    redirect_to cart_index_path
  end

  def destroy
    sticker = Sticker.find(params[:id])
    @cart.remove_sticker(sticker.id)
    session[:cart] = @cart.contents
    flash[:success] = "Successfully removed #{view_context.link_to "#{sticker.title}", sticker_path(sticker.id)} sticker from your cart.".html_safe
    redirect_to cart_index_path
  end
end
