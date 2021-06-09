class ItemTagMt < ApplicationRecord
  belongs_to :item
  belongs_to :tag

  validates :item_id, uniqueness: { scope: :tag_id }  # 組み合わせを一意にする
end

# == Schema Information
#
# Table name: item_tag_mts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_item_tag_mts_on_item_id             (item_id)
#  index_item_tag_mts_on_item_id_and_tag_id  (item_id,tag_id) UNIQUE
#  index_item_tag_mts_on_tag_id              (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (tag_id => tags.id)
#
