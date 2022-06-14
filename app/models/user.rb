class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'author_id'
  has_many :likes, class_name: 'Like', foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_3_posts
    posts.where(author: self).last(3)
  end

  def default_image
    'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/apps/1684840/ff056d537780500b7ed8823881b014176c6f2085.jpg'
  end
end
