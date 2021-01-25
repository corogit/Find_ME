class Genre < ApplicationRecord
  has_many :pets, dependent: :destroy
  
  validates :name, presence: true
  validates :is_active, inclusion: { in: [true, false] }
end
