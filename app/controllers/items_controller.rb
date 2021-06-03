class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :check_user, except: %i[index]

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

  private

  def image_genre_params
    params.require(:image_genre).permit(:name, :comment, :genre_id, :image).merge(user_id: current_user.id)
  end

  def check_user
    redirect_to(root_path) unless current_user.id == Item.find(params[:user_id]).user_id
  end
end
