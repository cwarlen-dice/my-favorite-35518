class Tag < ApplicationRecord
  has_many :item_tag_mts
  has_many :items, through: :item_tag_mts

  validates :name, uniqueness: true
end
