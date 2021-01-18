class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :image, presence: true
  validates :name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  attachment :image
end
