class Item < ApplicationRecord
  has_one_attached :image
  has_many :item_genre_mts
  belongs_to :user
  has_many :item_tag_mts
  has_many :tags, through: :item_tag_mts

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre, through: :item_genre_mts

  is_impressionable counter_cache: true
end

# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#