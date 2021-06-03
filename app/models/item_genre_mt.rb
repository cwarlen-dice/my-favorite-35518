class ItemGenreMt < ApplicationRecord
  belongs_to :item
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre, through: :item_genre_mts
end

# == Schema Information
#
# Table name: item_genre_mts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint           not null
#  item_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_item_genre_mts_on_genre_id  (genre_id)
#  index_item_genre_mts_on_item_id   (item_id)
#  index_item_genre_mts_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
