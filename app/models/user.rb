class User < ApplicationRecord
  has_many :posts
  has_many :comments

  def last_3_posts
    Post.where(author: self).last(3)
  end
end
