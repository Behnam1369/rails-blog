class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  def update_comments_counter
    post = self.post
    post.comments_counter = post.comments_counter.nil? ? 1 : post.comments_counter + 1
    post.save
  end
end
