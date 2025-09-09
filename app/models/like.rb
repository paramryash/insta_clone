# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :account
  belongs_to :post
  validates_uniqueness_of :account_id, scope: :post_id
end
