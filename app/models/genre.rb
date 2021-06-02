class Genre < ActiveHash::Base
  self.data = [
    { id: 0, data: '--' },
    { id: 1, data: 'アニメ' },
    { id: 2, data: 'ライトノベル' },
    { id: 3, data: 'イラスト' },
    { id: 4, data: '風景' }
    { id: 5, data: '動物' }
    { id: 6, data: '人物' }
  ]

  include ActiveHash::Associations
  has_many :users
end
