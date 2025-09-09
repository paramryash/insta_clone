# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :follower, null: false, foreign_key: {to_table: :accounts}
      t.references :followed, null: false, foreign_key: {to_table: :accounts}
      t.timestamps
    end

    add_index :follows, %i[follower_id followed_id], unique: true
  end
end
