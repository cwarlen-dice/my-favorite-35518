class Genre < ActiveHash::Base
  self.data = [
    { id: 0, data: 'ジャンル未設定' },
    { id: 1, data: 'アニメ' },
    { id: 2, data: 'ライトノベル' },
    { id: 3, data: 'イラスト' },
    { id: 4, data: '風景' },
    { id: 5, data: '動物' },
    { id: 6, data: '人物' }
  ]
  include ActiveHash::Associations
  # has_many :item_genre_mts
  # has_many :items, through: :item_genre_mts
  has_one :item_genre_mt
  has_one :item, through: :item_genre_mt
end
