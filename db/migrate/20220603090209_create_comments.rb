class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.bigint :author_id, index: true
      t.bigint :post_id, index: true
      t.string :text

      t.timestamps
    end
    
    add_foreign_key :comments, :users, column: :author_id, primary_key: :id
    add_foreign_key :comments, :posts, column: :post_id, primary_key: :id
  end
end
