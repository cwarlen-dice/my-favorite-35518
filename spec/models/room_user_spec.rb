require 'rails_helper'

RSpec.describe RoomUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: room_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_room_users_on_room_id              (room_id)
#  index_room_users_on_user_id              (user_id)
#  index_room_users_on_user_id_and_room_id  (user_id,room_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (user_id => users.id)
#
