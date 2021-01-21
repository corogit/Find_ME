class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :last_name, presence: true, length: { in:2..20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :pets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries

  attachment :profile_image

  has_many :relationships, foreign_key: "follower_id", class_name: "Relationship",
                           dependent: :destroy
  has_many :followings, through: :relationships, source: :following
  has_many :reverse_of_relationships, foreign_key: "following_id", class_name: "Relationship",
                                      dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

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
