class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    unless authorized?
      redirect_to root_url, danger: "Stranger danger!"
    end
  end
  before_action :authorize!

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end

  # def current_admin?
  #   current_user && current_user.admin?
  # end

  def not_found
  end
end
