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
    @is_room = room_check(params[:user_id])
    redirect_to(user_message_rooms_path(params[:user_id])) and return unless @is_room.blank?

    @user = User.find(params[:user_id])
    # # @permit_image = PermitImage.new
    # ids = []
    # permit_images = @user.permit_images
    # @smple_imgs = []
    # permit_images.each do |i|
    #   smple_img = [1, 2, 3]
    #   smple_img << i.item.image
    #   smple_img = smple_img.shuffle
    #   @smple_imgs << [i.item.item_genre_mt.genre.id, smple_img]
    # end

    ids = []
    @user.permit_images.each { |img| ids << img.item_id }
    id_conut = ids.length
    digits = ids.max.to_s.length
    range = 10 * (10**digits)
    rand_num = (1..range).to_a.sample(3 * id_conut)
    replace_num(ids, range, rand_num) unless (ids & rand_num).blank?
    @smple_imgs = []
    # binding.pry
  end

  def check
    # binding.pry
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
end
