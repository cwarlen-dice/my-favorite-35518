# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthday               :date
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default(""), not null
#  impressions_count      :integer          default(0), not null
#  nickname               :string(255)      not null
#  prorile                :text(65535)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  blood_type_id          :string(255)
#
# Indexes
#
#  index_users_on_nickname              (nickname) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
