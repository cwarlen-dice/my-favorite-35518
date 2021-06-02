class CreateItemGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :item_genres do |t|
      t.references :item, foreign_key: true, null: false
      t.references :genre, foreign_key: true, null: false
      t.timestamps
    end
  end
end
