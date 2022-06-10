class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  def update_like_counter
    post = self.post
    post.likes_counter = post.likes_counter.nil? ? 1 : post.likes_counter + 1
    post.save
  end
end
