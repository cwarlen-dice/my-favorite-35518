class ItemsTag
  include ActiveModel::Model
  attr_accessor :message, :name

  with_options presence: true do
    validates :message
    validates :name
  end

  def save
    item = Item.create(message: message)
    tag = Tag.create(name: name)

    TweetTagRelation.create(tweet_id: item.id, tag_id: tag.id)
  end
end
