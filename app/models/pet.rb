class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :pet_images, dependent: :destroy
  accepts_attachments_for :pet_images, attachment: :image

  
  validates :name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :introduction, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end



  enum gender: { 男の子♂: 0, 女の子♀: 1 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture


# here
  scope :search, -> (search_params) do      #scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

    # prefecture(search_params[:prefecture])
      birthday_from(search_params[:birthday_from])
      .birthday_to(search_params[:birthday_to])
      .prefecture_id_is(search_params[:prefecture_id])
      .gender_is(search_params[:gender])
      .genre_id_is(search_params[:genre_id])
        #下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  end

 #scopeを定義。
  scope :birthday_from, -> (from) { where('? <= birthday', from) if from.present? }
  scope :birthday_to, -> (to) { where('birthday <= ?', to) if to.present? }
  scope :prefecture_id_is, -> (prefecture_id) { where(prefecture_id: prefecture_id) if prefecture_id.present? }
  scope :gender_is, -> (gender) { where(gender: gender) if gender.present? }
  scope :genre_id_is, -> (genre_id) { where(genre_id: genre_id) if genre_id.present? }

 #scope :メソッド名 -> (引数) { SQL文 }
# end
 
end
