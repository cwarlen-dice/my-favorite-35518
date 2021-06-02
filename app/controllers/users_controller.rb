class UsersController < ApplicationController
  before_action :admin
  before_action :set_user, only: %i[edit update show]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to(user_path(params[:id]))
    else
      render :edit
    end
  end

  def show
    impressionist(@user) # PVカウントアップ
  end

  private

  def user_params
    params.require(:user).permit(:birthday, :blood_type_id, :prorile, :image)
  end

  def admin
    redirect_to(admin_root_path) and return if request.referer.include?('admin/login')
  end

  def set_user
    @user = User.find(params[:id])
  end
end
