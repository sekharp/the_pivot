class LendersController < ApplicationController
  def new
    @user = User.new
    @user.roles << Role.find_by(name: 'lender')
  end
end
