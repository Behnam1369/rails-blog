class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :increment_counter_for_post
  after_destroy :decrement_counter_for_post

  def update_post_counter
    author = self.author
    author.save
  end

  def last_5_comments
    comments.where(post: self).last(5)
  end

  private

  def increment_counter_for_post
    author = self.author
    author.increment!(:posts_counter)
  end

  def decrement_counter_for_post
    author = self.author
    author.decrement!(:posts_counter)
  end
end
