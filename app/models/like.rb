class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  def update_like_counter
    author = self.author
    author.likes_counter = author.likes_counter.nil? ? 1 : author.likes_counter + 1
    author.save
  end
end
