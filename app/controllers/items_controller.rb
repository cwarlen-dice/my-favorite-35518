class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :no_user, except: %i[index]
  before_action :set_user, except: %i[index]
  before_action :check_user, except: %i[index show]

  def index
  end

  def new
    @image_genre = ImageGenre.new
  end

  def create
    @image_genre = ImageGenre.new(image_genre_params)
    if @image_genre.valid?
      @image_genre.save
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

  def image_genre_params
    params.require(:image_genre).permit(:name, :comment, :genre_id, :image).merge(user_id: current_user.id)
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
