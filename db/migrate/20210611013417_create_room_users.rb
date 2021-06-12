class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.timestamps
    end
    add_index :room_users, [:user_id, :room_id], unique: true   # 組み合わせを一意にする
  end
end
