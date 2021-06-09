class SelectsController < ApplicationController
  def index
    case params[:select]
    when 'tag'
      sql = "SELECT `item_tag_mts`.* FROM `item_tag_mts` WHERE \
      `item_tag_mts`.`tag_id` = #{params[:tag_id]} ORDER BY updated_at DESC"
      @tag = Tag.find(params[:tag_id]).name
    when 'genre'
      sql = "SELECT `item_genre_mts`.* FROM `item_genre_mts` WHERE \
      `item_genre_mts`.`genre_id` = #{params[:genre_id]} ORDER BY updated_at DESC"
      @genre = Genre.find(params[:genre_id])[:data]
    end
    @select_items = ItemTagMt.includes(:item).find_by_sql(sql)
    # binding.pry
  end
end
