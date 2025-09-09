class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :account, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
     

      t.timestamps
    end
  end
end

# t.references :account, null: false, foreign_key: {to_table: :accounts}
# t.references :post, null: false, foreign_key: {to_table: :posts}