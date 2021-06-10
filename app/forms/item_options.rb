class ItemOptions
  include ActiveModel::Model
  attr_accessor :name, :comment, :genre_id, :image, :user_id, :tags, :item_id

  with_options presence: true do
    validates :image, if: :item_id?
    validates :tags
  end

  def item_id?
    item_id.nil?
  end

  def save
    name = File.basename(image.original_filename, '.*') if name.blank?
    item = Item.create(name: name, comment: comment, image: image, user_id: user_id)
    ItemGenreMt.create(item_id: item.id, genre_id: genre_id, user_id: user_id)
    tags.uniq!
    new_tags = tags.reject(&:blank?)
    new_tags.each do |tag_name|
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save
      ItemTagMt.create(item_id: item.id, tag_id: tag.id)
    end
  end

  def update
    item = Item.find(item_id)
    if image.blank?
      item.update!(name: name, comment: comment, user_id: user_id)
    else
      item.update!(name: name, comment: comment, user_id: user_id, image: image)
    end
    item_g_m = ItemGenreMt.find_by(item_id: item_id)
    item_g_m.update!(item_id: item_id, genre_id: genre_id, user_id: user_id)
    tags.uniq!
    new_tags = tags.reject(&:blank?)
    old_tags = []
    item.tags.each do |tag|
      old_tags << tag.name
    end
    old_only = old_tags - new_tags
    new_only = new_tags - old_tags
    old_only.each do |tag_name|
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save
      del_tag = ItemTagMt.find_by(item_id: item_id, tag_id: tag.id)
      del_tag.destroy
    end
    new_only.each do |tag_name|
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save
      ItemTagMt.create(item_id: item_id, tag_id: tag.id)
    end
  end
end
