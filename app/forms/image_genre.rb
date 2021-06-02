class ImageGenre
  include ActiveModel::Model
  attr_accessor :name, :comment, :genre_id, :image, :user_id

  validates :image, presence: true

  def save
    name = image.original_filename if name.blank?
    item = Item.create(name: name, comment: comment, image: image, user_id: user_id)
    ItemGenreMt.create(item_id: item.id, genre_id: genre_id)
  end
end
