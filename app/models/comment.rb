class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_save :increment_counter_for_post
  after_destroy :decrement_counter_for_post

  def update_comments_counter
    post.update(comments_counter: Comment.where(post:).count)
  end

  def delete
  end

  private

  def increment_counter_for_post
    post.increment!(:comments_counter)
  end

  def decrement_counter_for_post
    post.decrement!(:comments_counter)
  end
end
