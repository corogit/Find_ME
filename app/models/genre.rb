class Genre < ApplicationRecord
  has_many :pets, dependent: :destroy
end
