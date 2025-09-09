# frozen_string_literal: true

class RemoveUserIdFromLikes < ActiveRecord::Migration[7.1]
  def change
    remove_column :likes, :user_id, :integer
  end
end
