class PermitsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
  end

  def new
    @user = User.find(params[:user_id])
    @permit_image = PermitImage.new
    genre_sql = "SELECT DISTINCT genre_id FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC"
    item_genre_sql = "SELECT * FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC, updated_at DESC"
    @genre = ItemGenreMt.find_by_sql(genre_sql)
    @item_genre = ItemGenreMt.find_by_sql(item_genre_sql)
  end

  def create
    items = []
    params[:item_ids].each_with_index do |id, i|
      items[i] = PermitImage.new(item_id: id, user_id: params[:user_id])
    end
    last_num = items.length - 1
    num = 0
    while items[num].valid?
      if num == last_num
        record_create(items)
        redirect_to(permits_path) and return
      end

      num += 1
    end

    @permit_image = items[num]
    @user = User.find(params[:user_id])
    genre_sql = "SELECT DISTINCT genre_id FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC"
    item_genre_sql = "SELECT * FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC, updated_at DESC"
    @genre = ItemGenreMt.find_by_sql(genre_sql)
    @item_genre = ItemGenreMt.find_by_sql(item_genre_sql)

    render :new
  end

  private

  def record_create(items)
    items.each do |item|
      item.save
    end
  end
end
