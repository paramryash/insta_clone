# frozen_string_literal: true

class AddUsernameToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :first_name, :string, limit: 30
    add_column :accounts, :last_name, :string, limit: 30
    add_column :accounts, :username, :string, limit: 30
  end
end
