class Tag < ApplicationRecord
  has_many :item_tag_mts
  has_many :items, through: :item_tag_mts

  validates :name, uniqueness: true
end

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
