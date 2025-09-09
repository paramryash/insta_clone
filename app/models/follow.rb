# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: "Account"
  belongs_to :followed, class_name: "Account"

  validates :follower_id, uniqueness: {scope: :followed_id}
end
