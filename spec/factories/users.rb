FactoryBot.define do
  factory :user do
    email	{ '' }
    password	{ Faker::Internet.password }
    password_confirmation { password }
    nickname	{ Faker::Name.name }
    birthday	{ Faker::Date.birthday }
    blood_type_id	{ Faker::Number.within(range: 1..3) }
    prorile	{ Faker::Lorem.sentence }

    after(:build) do |user|
      user.image.attach(io: File.open('public/images/1702.png'), filename: 'public/images/1702.png', content_type: 'image/png')
    end
  end
end
