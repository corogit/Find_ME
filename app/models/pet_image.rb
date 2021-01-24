class PetImage < ApplicationRecord
  belongs_to :pet
  attachment :image
end
