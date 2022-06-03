class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.bigint :author_id, index: true
      t.bigint :post_id, index: true

      t.timestamps
    end

    add_foreign_key :likes, :users, column: :author_id, primary_key: :id
    add_foreign_key :likes, :posts, column: :post_id, primary_key: :id
  end
end
