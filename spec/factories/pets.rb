FactoryBot.define do
  factory :pet do
    name { Faker::Lorem.characters(number: 7) }
    introduction { Faker::Lorem.characters(number: 200) }
    user
  end
end