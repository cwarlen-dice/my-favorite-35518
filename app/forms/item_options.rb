class ItemOptions
  include ActiveModel::Model
  attr_accessor :name, :comment, :genre_id, :image, :user_id, :tags

  with_options presence: true do
    validates :image
    validates :tags
  end

  def save
    name = image.original_filename if name.blank?
    item = Item.create(name: name, comment: comment, image: image, user_id: user_id)
    ItemGenreMt.create(item_id: item.id, genre_id: genre_id, user_id: user_id)
    tags.each do |tag_name|
      next if tag_name.blank?

      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save
      ItemTagMt.create(item_id: item.id, tag_id: tag.id)
    end
  end
end
