class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_create :increment_counter_for_like
  after_destroy :decrement_counter_for_like

  def update_like_counter
    post = self.post
    post.likes_counter = post.likes_counter.nil? ? 1 : post.likes_counter + 1
    post.save
  end

  private

  def increment_counter_for_like
    post.increment!(:likes_counter)
  end

  def decrement_counter_for_like
    post.decrement!(:likes_counter)
  end
end
