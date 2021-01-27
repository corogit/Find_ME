FactoryBot.define do
  factory :user do
    last_name { Faker::Lorem.characters(number: 10) }
    first_name { Faker::Lorem.characters(number: 10) }
    last_name_kana { Faker::Lorem.characters(number: 10) }
    first_name_kana { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    address { Faker::Lorem.characters(number: 20) }
    zipcode { Faker::Lorem.characters(number: 7) }
    phone_number { Faker::Lorem.characters(number: 11) }
    is_deleted { false }
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
