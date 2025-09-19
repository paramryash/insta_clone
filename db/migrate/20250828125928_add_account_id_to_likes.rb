class AddAccountIdToLikes < ActiveRecord::Migration[7.1]
  def change
    add_reference :likes, :account, null: false, foreign_key: { on_delete: :cascade }
  end
end
