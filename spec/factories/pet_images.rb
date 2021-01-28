FactoryBot.define do
  factory :pet_image, class: Pet do
    image { Rack::Test::UploadedFile.new(Rails.root + "app/assets/images/no_image.jpg", "image/jpg") }
  end
end
