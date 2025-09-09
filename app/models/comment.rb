class Comment < ApplicationRecord
  default_scope { order created_at: :desc }
  belongs_to :account
  belongs_to :post

  validates :body, presence: true   

   belongs_to :parent, class_name: "Comment", optional: true
   has_many :replies,class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
     scope :top_level, -> { where(parent_id: nil) }
end
