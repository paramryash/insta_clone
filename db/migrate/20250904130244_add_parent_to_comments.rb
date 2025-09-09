class AddParentToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :parent, null: true, foreign_key: {to_table: :comments}
  end
end
