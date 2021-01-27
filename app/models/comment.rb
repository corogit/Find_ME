class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :pet

  validates :comment, presence: true
end
