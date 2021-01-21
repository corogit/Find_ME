FactoryBot.define do
  factory :user do
    last_name { Faker::Lorem.characters(number: 10) }
    first_name { Faker::Lorem.characters(number: 10) }
    last_name_kana { Faker::Lorem.characters(number: 10) }
    first_name_kana { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    address { Faker::Lorem.characters(number:30) }
    zipcode { '6666666' }
    phone_number { '0909999999' }
    is_deleted { false }
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end