require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.new(name: 'behnam', posts_counter: 0)
  user.save
  post = Post.new(title: 'something', text: 'post body', author: user, comments_counter: 0, likes_counter: 0)
  post.save
  comment = Comment.new(author: user, post:, text: 'something')

  it 'update_comments_counter method should increment counter of post instance' do
    comment.update_comments_counter
    expect(post.comments_counter).to eq(1)
  end
end
