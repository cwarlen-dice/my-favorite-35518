class UsersController < ApplicationController
  # def index
  #   @user = User.find(params[:format])
  #   impressionist(@user) # PVカウントアップ
  # end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to(user_path(params[:id]))
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    # binding.pry
    impressionist(@user) # PVカウントアップ
  end

  private

  def user_params
    params.require(:user).permit(:birthday, :blood_type_id, :prorile, :image)
  end
end
