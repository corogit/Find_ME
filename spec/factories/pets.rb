FactoryBot.define do
  factory :pet, class: Pet do
    name { 'ポチ' }
    birthday { '2020-1-1' }
    age { '1' }
    gender { '男の子♂' }
    introduction { 'よろしくお願いします。' }
    image {Rack::Test::UploadedFile.new(Rails.root + "app/assets/images/no_image.jpg", "image/jpg")} #{ File.open("#{Rails.root}/app/assets/images/no_image.jpg") }
    user
    genre
    prefecture
  end
end
