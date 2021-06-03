class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
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
    @item = Item.find(params[:id])
  end

  private

  def image_genre_params
    params.require(:image_genre).permit(:name, :comment, :genre_id, :image).merge(user_id: current_user.id)
  end

  def check_user
    redirect_to(root_path) and return if params[:user_id].nil? && (current_user.id != params[:user_id].to_i)
  end
end
