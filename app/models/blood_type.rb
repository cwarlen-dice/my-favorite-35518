class BloodType < ActiveHash::Base
  self.data = [
    { id: 0, data: '--' },
    { id: 1, data: 'A' },
    { id: 2, data: 'B' },
    { id: 3, data: 'AB' },
    { id: 4, data: 'O' }
  ]

  include ActiveHash::Associations
  has_many :users
end
