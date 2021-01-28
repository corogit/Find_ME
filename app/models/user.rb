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

  validates :last_name, presence: true
  validates :first_name, presence: true
  VALID_KANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/.freeze
  validates :last_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  validates :first_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :zipcode, presence: true
  validates :address, presence: true
  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/.freeze
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
  
  def self.guest
    find_or_create_by!(last_name: 'テスト',
    first_name: 'テスト',
    last_name_kana: 'テスト',
    first_name_kana: 'テスト',
    zipcode: '6666666',
    address: '東京都1-1-1',
    phone_number: '0900000000',
    email: 'test@example.com'
    ) do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end
  
end
