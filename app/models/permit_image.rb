class PermitImage < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :user_id, uniqueness: { scope: :item_id }  # 組み合わせを一意にする
end
