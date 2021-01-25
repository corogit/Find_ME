class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries

  attachment :profile_image
  attachment :image

  has_many :relationships, foreign_key: "follower_id", class_name: "Relationship",
                           dependent: :destroy
  has_many :followings, through: :relationships, source: :following
  has_many :reverse_of_relationships, foreign_key: "following_id", class_name: "Relationship",
                                      dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :last_name, presence: true, uniqueness: true
  validates :first_name, presence: true
  VALID_KANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/
  validates :last_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  validates :first_name_kana, presence: true,  format: { with: VALID_KANA_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :zipcode, presence: true
  validates :address, presence: true
  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }
  validates :introduction, length: { maximum: 50 }

  def follow(other_user)
    unless self == other_user
      relationships.find_or_create_by(following_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = relationships.find_by(following_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def full_name
    last_name + first_name
  end
end
