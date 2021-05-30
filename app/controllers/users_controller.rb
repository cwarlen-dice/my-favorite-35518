class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    impressionist(@user) # PVカウントアップ
  end
end
