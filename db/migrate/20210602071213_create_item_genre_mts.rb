class CreateItemGenreMts < ActiveRecord::Migration[6.0]
  def change
    create_table :item_genre_mts do |t|
      t.references :item, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.references :genre, null: false
      t.timestamps
    end
  end
end
