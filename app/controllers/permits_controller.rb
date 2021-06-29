class PermitsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_genre_data, only: %i[new create edit update]

  def index
  end

  def new
    @permit_image = PermitImage.new
  end

  def create
    items = []
    ids = params[:check_ids]
    if ids.blank?
      items << PermitImage.new(item_id: '', user_id: params[:user_id])
    else
      ids.each do |id|
        items << PermitImage.new(item_id: id, user_id: params[:user_id])
      end
    end
    redirect_to(message_info_path) and return if items.map(&:save).all? # 全ての値を保存

    @permit_image = items
    render :new
  end

  def edit
    @permit_image = PermitImage.new
  end

  def update
    if image_update
      redirect_to(message_info_path)
    else
      @permit_image = @items
      render :edit
    end
  end

  def permit_select
    @user = User.find(params[:user_id])
    @is_room = room_check(params[:user_id])
    if @is_room.blank?
      get_images(params[:user_id])
    else
      redirect_to(create_user_message_rooms_path(params[:user_id]))
    end
  end

  def check
    get_images(params[:user_id])
    check_ids = params[:check_ids].map(&:to_i)
    if check_ids.sort == @ids.sort
      redirect_to(create_user_message_rooms_path(params[:user_id]))
    else
      render :permit_select
    end
  end

  private

  def set_genre_data
    @user = User.find(params[:user_id])
    item_genre_sql = "SELECT * FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC, updated_at DESC"
    @item_genre = ItemGenreMt.find_by_sql(item_genre_sql)
    genre_sql = "SELECT DISTINCT genre_id FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC"
    @genres = ItemGenreMt.find_by_sql(genre_sql)
  end

  def image_update
    @items = ''
    old_list = []
    current_user.permit_images.each do |i|
      old_list << i.item_id
    end
    new_list = params[:check_ids]
    new_list = [] if new_list.blank?
    old_only = old_list - new_list
    new_only = new_list - old_list
    old_only.each do |id|
      item = PermitImage.find_by(item_id: id)
      @items << item unless item.destroy
    end
    new_only.each do |id|
      item = PermitImage.new(item_id: id, user_id: params[:user_id])
      @items << item unless item.save
    end
  end

  def replace_num(ids, range, rand_num)
    common = ids & rand_num
    common.each do |num|
      rand_num.delete(num)
      add_num = rand(range)
      add_num = rand(range) while rand_num.include?(add_num) || ids.include?(add_num)
      rand_num.push(add_num) unless rand_num.include?(add_num)
    end
  end

  def get_images(send_id)
    @ids = []
    @user = User.find(send_id)
    @images = @user.permit_images.each { |img| @ids << img.item_id }
    return if @ids.blank?

    id_conut = @ids.length
    digits = @ids.max.to_s.length
    range = 10 * (10**digits)
    rand_num = (1..range).to_a.sample(3 * id_conut)
    replace_num(@ids, range, rand_num) unless (@ids & rand_num).blank?
    @smple_imgs = rand_num.each_slice(3).to_a
    @smple_imgs.each_with_index do |smple_img, i|
      smple_img << @images[i]
      smple_img.shuffle!
      @smple_imgs[i] = [@images[i].item.item_genre_mt.genre_id, smple_img]
    end
    @smple_imgs.shuffle!
  end
end
