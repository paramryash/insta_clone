class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  belongs_to :account
  has_one_attached :image
  has_many :likes,dependent: :destroy
  # has_many :likers, through: :likes, source: :account
  has_many :comments, dependent: :destroy

  scope :active, -> { where active: true }

  def likes_count
    likes.count
  end
end
