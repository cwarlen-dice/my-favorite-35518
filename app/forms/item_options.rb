class ItemOptions
  include ActiveModel::Model
  attr_accessor :name, :comment, :genre_id, :image, :user_id, :tag_name

  with_options presence: true do
    validates :image
    validates :tag_name
  end

  def save
    name = image.original_filename if name.blank?
    item = Item.create(name: name, comment: comment, image: image, user_id: user_id)
    ItemGenreMt.create(item_id: item.id, genre_id: genre_id, user_id: user_id)
    tag = Tag.where(name: tag_name).first_or_initialize
    tag.save
    ItemTagMt.create(item_id: item.id, tag_id: tag.id)
  end
end
