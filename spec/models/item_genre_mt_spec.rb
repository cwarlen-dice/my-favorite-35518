require 'rails_helper'

RSpec.describe ItemGenreMt, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: item_genre_mts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint           not null
#  item_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_item_genre_mts_on_genre_id  (genre_id)
#  index_item_genre_mts_on_item_id   (item_id)
#  index_item_genre_mts_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
