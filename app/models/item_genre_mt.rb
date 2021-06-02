class ItemGenreMt < ApplicationRecord
  belongs_to :item

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
end

# == Schema Information
#
# Table name: item_genre_mts
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  genre_id_id :bigint           not null
#  item_id     :bigint           not null
#
# Indexes
#
#  index_item_genre_mts_on_genre_id_id  (genre_id_id)
#  index_item_genre_mts_on_item_id      (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#
