class LendersController < ApplicationController
  def new
    @user = User.new
  end
end
