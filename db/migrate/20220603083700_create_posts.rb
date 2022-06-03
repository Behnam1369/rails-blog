class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.bigint :author_id, index: true
      t.string :title
      t.string :text

      t.timestamps
      t.integer :comments_counter
      t.integer :likes_counter
    end

    add_foreign_key :posts, :users, column: :author_id, primary_key: :id
  end
end
