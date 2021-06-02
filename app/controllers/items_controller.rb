class ItemsController < ApplicationController
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

  def image_genre_params
    params.require(:image_genre).permit(:name, :comment, :genre_id, :image).merge(user_id: current_user.id)
  end
end
