class UsersController < ApplicationController
  before_action :admin
  before_action :authenticate_user!, except: %i[show]
  before_action :no_user
  before_action :set_user
  before_action :check_user, except: %i[show]

  def edit
  end

  def update
    @user.blood_type_id = nil unless @user.blood_type_id.nil? || !@user.blood_type_id.zero?
    if @user.update(user_params)
      redirect_to(user_path(params[:id]))
    else
      render :edit
    end
  end

  def show
    genre_sql = "SELECT DISTINCT genre_id FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC"
    @genres = ItemGenreMt.find_by_sql(genre_sql)
    item_genre_sql = "SELECT * FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC, updated_at DESC"
    @item_genre = ItemGenreMt.find_by_sql(item_genre_sql)
    impressionist(@user) if @user.id != current_user.id # PVカウントアップ
  end

  private

  def user_params
    params.require(:user).permit(:birthday, :blood_type_id, :profile, :image)
  end

  def admin
    redirect_to(admin_root_path) and return if !request.referer.nil? && request.referer.include?('admin/login')
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_user
    redirect_to(root_path) and return unless current_user.id == @user.id
  end

  def no_user
    redirect_to(root_path) if User.find_by(id: params[:id]).nil?
  end
end
