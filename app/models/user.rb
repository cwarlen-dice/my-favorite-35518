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
#  profile                :text(65535)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  blood_type_id          :integer
#
# Indexes
#
#  index_users_on_nickname              (nickname) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image
  has_many :items
  has_many :permit_images
  # has_many :item_genre_mts
  # has_one :item_genre_mt
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :blood_type

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, uniqueness: { case_sensitive: true }, presence: true
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/ }, allow_blank: true

  is_impressionable counter_cache: true

  # 登録時に email を不要にする
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
