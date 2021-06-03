class UsersController < ApplicationController
  before_action :admin
  before_action :set_user, only: %i[edit update show]

  def edit
  end

  def update
    @user.blood_type_id = nil if @user.blood_type_id.zero?
    if @user.update(user_params)
      redirect_to(user_path(params[:id]))
    else
      render :edit
    end
  end

  def show
    genre_sql = "SELECT DISTINCT genre_id FROM item_genre_mts WHERE user_id=#{current_user.id} ORDER BY genre_id ASC"
    item_genre_sql = "SELECT item_id,genre_id FROM item_genre_mts WHERE user_id=#{current_user.id} ORDER BY genre_id ASC"
    @genre = ItemGenreMt.find_by_sql(genre_sql)
    @item_genre = ItemGenreMt.find_by_sql(item_genre_sql)
    # @genre = ItemGenreMt.includes(:item).find_by_sql(sql)
    # binding.pry
    impressionist(@user) # PVカウントアップ
  end

  private

  def user_params
    params.require(:user).permit(:birthday, :blood_type_id, :profile, :image)
  end

  def admin
    redirect_to(admin_root_path) and return if request.referer.include?('admin/login')
  end

  def set_user
    @user = User.find(params[:id])
  end
end
