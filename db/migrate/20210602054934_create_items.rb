class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name
      t.text :comment
      t.timestamps
    end
  end
end
