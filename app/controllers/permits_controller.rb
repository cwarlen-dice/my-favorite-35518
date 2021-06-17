class PermitsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_genre_data, only: %i[new create edit update]
  before_action :items_create, only: %i[create update]

  def index
  end

  def new
    # binding.pry
    @permit_image = PermitImage.new
  end

  def create
    # items = []
    # params[:check_ids].each do |id|
    #   items << PermitImage.new(item_id: id, user_id: params[:user_id])
    # end
    if @items.map(&:valid?).all? # 全て登録できるか確認
      @items.map(&:save).all? # 全ての値を保存
      redirect_to(message_info_path) and return
    else
      @permit_image = @items
      render :new
    end
  end

  def edit
    @permit_image = PermitImage.new
  end

  def update
    # items = items_create(params[:check_ids])
    binding.pry
    @permit_image = @items
    render :edit
  end

  def check
    @permit_image = PermitImage.new
    permit_images = current_user.permit_images
    @smple_imgs = []
    permit_images.each do |i|
      smple_img = [1, 2, 3]
      smple_img << i.item.image
      smple_img = smple_img.shuffle
      @smple_imgs << [i.item.item_genre_mt.genre.id, smple_img]
    end
    # binding.pry
  end

  private

  def set_genre_data
    @user = User.find(params[:user_id])
    item_genre_sql = "SELECT * FROM item_genre_mts WHERE user_id=#{@user.id} ORDER BY genre_id ASC, updated_at DESC"
    @item_genre = ItemGenreMt.find_by_sql(item_genre_sql)
  end

  def items_create
    @items = []
    params[:check_ids].each do |id|
      @items << PermitImage.new(item_id: id, user_id: params[:user_id])
    end
  end
end
