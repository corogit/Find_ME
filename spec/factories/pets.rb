FactoryBot.define do
  factory :pet do
    name { Faker::Lorem.characters(number: 9) }
    birthday { '2020-1-1' }
    age { '1' }
    gender { '男の子♂' }
    introduction { 'よろしくお願いします。' }
    image { File.open('./app/assets/images/no_image.jpg', ?r) }
    user
    genre
    prefecture
  end
end
