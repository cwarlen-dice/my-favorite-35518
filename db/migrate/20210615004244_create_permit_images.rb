class CreatePermitImages < ActiveRecord::Migration[6.0]
  def change
    create_table :permit_images do |t|
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :permit_images, [:item_id, :user_id], unique: true   # 組み合わせを一意にする
  end
end
