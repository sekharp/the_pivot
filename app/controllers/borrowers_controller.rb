class BorrowersController < ApplicationController
  def new
    @user = User.new
    @user.roles << Role.find_by(name: 'borrower')
  end
end
