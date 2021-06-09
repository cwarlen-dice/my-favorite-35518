class CreateItemTagMts < ActiveRecord::Migration[6.0]
  def change
    create_table :item_tag_mts do |t|
      t.references :item, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
    add_index :item_tag_mts, [:item_id, :tag_id], unique: true   # 組み合わせを一意にする
  end
end
