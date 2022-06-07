class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def update_post_counter
    author = self.author
    author.posts_counter = author.posts_counter.nil? ? 1 : author.posts_counter + 1
    author.save
  end

  def last_5_comments
    comments.where(post: self).last(5)
  end
end
