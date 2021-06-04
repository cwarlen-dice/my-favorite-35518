class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :no_user, except: %i[index]
  before_action :set_user, except: %i[index]
  before_action :check_user, except: %i[index show]

  def index
  end

  def new
    @item_options = ItemOptions.new
  end

  def create
    @item_options = ItemOptions.new(item_options_params)
    if @item_options.valid?
      @item_options.save
      redirect_to(user_path(current_user.id)) and return
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @item = Item.find(params[:id])
    impressionist(@item) # PVカウントアップ
  end

  private

  def item_options_params
    params.require(:item_options).permit(:name, :comment, :tag_name, :genre_id, :image).merge(
      user_id: current_user.id
    )
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
end
