class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user
      if @user.admin? && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to admin_dashboard_path(id: @user.id)
      elsif @user && @user.authenticate(params[:session][:password]) && @user.lender?
        session[:user_id] = @user.id
        if @cart.contents.empty?
          redirect_to lender_dashboard_path
        else
          redirect_to cart_index_path
        end
      elsif @user && @user.authenticate(params[:session][:password]) && @user.borrower?
        session[:user_id] = @user.id
        redirect_to borrower_dashboard_path
      else
        flash.now[:error] = "Invalid username or password. Try again."
        render :new
      end
    else
      flash[:errors] = "Please create account first"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:logout] = "Goodbye!"
    redirect_to login_path
  end
end
