class Item < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  has_many :item_genre_mts, dependent: :destroy
  belongs_to :user
  has_many :item_tag_mts, dependent: :destroy
  has_many :tags, through: :item_tag_mts
  has_many :permit_images, through: :users

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre, through: :item_genre_mts

  is_impressionable counter_cache: true
end

# == Schema Information
#
# Table name: items
#
#  id                :bigint           not null, primary key
#  comment           :text(65535)
#  impressions_count :integer          default(0), not null
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
