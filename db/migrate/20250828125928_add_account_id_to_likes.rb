# frozen_string_literal: true

class AddAccountIdToLikes < ActiveRecord::Migration[7.1]
  def change
    add_reference :likes, :account, null: false, foreign_key: true
  end
end
