class BorrowersController < ApplicationController
  def new
    @user = User.new
  end
end
