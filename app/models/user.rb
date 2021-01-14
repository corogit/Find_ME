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
  
  has_many :relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :followings, through: :relationships, source: :following
  has_many :reverse_of_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(following_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(following_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  
  
  def full_name
    self.last_name + self.first_name
  end
end