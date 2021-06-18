class PermitImage < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :item_id, uniqueness: { scope: :user_id }  # 組み合わせを一意にする
end

# == Schema Information
#
# Table name: permit_images
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_permit_images_on_item_id              (item_id)
#  index_permit_images_on_item_id_and_user_id  (item_id,user_id) UNIQUE
#  index_permit_images_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
