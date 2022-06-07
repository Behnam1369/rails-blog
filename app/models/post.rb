class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def update_post_counter
    author = self.author
    if author.posts_counter.nil?
      author.posts_counter = 1
    else
      author.posts_counter += 1
    end
    author.save
  end

  def last_5_comments
    Comment.where(post: self).last(5)
  end
end
