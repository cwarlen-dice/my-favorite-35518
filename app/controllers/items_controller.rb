class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show select]
  before_action :no_user, except: %i[index show select]
  before_action :set_user, except: %i[index select], if: :user_in?
  before_action :check_user, except: %i[index show select]
  before_action :set_one_item, only: %i[edit update]

  def index
  end

  def new
    @item_options = ItemOptions.new
  end

  def create
    item_create = ItemOptions.new(item_options_params)
    if item_create.valid?
      item_create.save
      redirect_to(user_path(current_user.id)) and return
    else
      @item_options = item_create
      render :new
    end
  end

  def edit
  end

  def update
    item_update = ItemOptions.new(item_options_params)
    if item_update.valid?
      item_update.update
      redirect_to(user_path(current_user.id)) and return
    else
      @item_options = item_update
      render :edit
    end
  end

  def show
    @item = Item.includes(:item_genre_mts).includes(:tags).find(params[:id])
    impressionist(@item) # PVカウントアップ
  end

  def select
    if params[:genre]
      @genre = Genre.find_by(data: params[:genre])
      sql = unless @genre.nil?
              "SELECT `item_genre_mts`.* FROM `item_genre_mts` WHERE \
      `item_genre_mts`.`genre_id` = #{@genre[:id]} ORDER BY updated_at DESC"
            end
    else
      @tag = Tag.find_by(name: params[:tag])
      sql = unless @tag.nil?
              "SELECT `item_tag_mts`.* FROM `item_tag_mts` WHERE \
      `item_tag_mts`.`tag_id` = #{@tag.id} ORDER BY updated_at DESC"
            end
    end

    @select_items = ItemTagMt.includes(:item).find_by_sql(sql) unless sql.nil?
  end

  private

  def item_options_params
    case action_name
    when 'create'
      params.require(:item_options).permit(:name, :comment, :genre_id, :image, tags: []).merge(
        user_id: current_user.id
      )
    when 'update'
      params.require(:item_options).permit(:name, :comment, :genre_id, :image, tags: []).merge(
        user_id: current_user.id, item_id: params[:id]
      )
    end
  end

  def check_user
    redirect_to(root_path) and return if current_user.id != @user.id
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def no_user
    redirect_to(root_path) if User.find_by(id: params[:user_id]).nil?
  end

  def set_one_item
    @item_options = Item.find(params[:id])
  end

  def user_in?
    user_signed_in?
  end
end
