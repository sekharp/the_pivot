class LoansController < ApplicationController
  before_action :require_login

  def index
    @loans = current_user.loans
  end

  def create
    if session[:cart].nil? || session[:cart].empty?
      redirect_to '/cart'
      flash[:notice] = "No loans in cart. Don't you want to loan money?"
    else
      session[:cart].each do |project_id, amount|
        Loan.create(project_id: project_id,
                    amount: amount,
                    user_id: current_user.id)
      end
      session[:cart] = {}
      flash[:success] = "Loan submitted"
      redirect_to lender_dashboard_path
    end
  end

  def show
    loan = Loan.find(params[:id].to_i)
    if current_user.id == loan.user.id
      @loan = loan
    else
      redirect_to loans_path
    end
  end

  private

  def require_login
    unless current_user
      flash[:error] = "Please log in or create an account before checking out"
      redirect_to login_path
    end
  end
end
