class PermitImage < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :item_id, uniqueness: { scope: :user_id }  # 組み合わせを一意にする
end
