require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.new(name: 'behnam', posts_counter: 0)
  user.save
  post = Post.new(title: 'something', text: 'post body', author: user, comments_counter: 0, likes_counter: 0)
  post.save
  like = Like.new(author: user, post:)

  it 'update_like_counter method should increment counter of post instance' do
    like.update_like_counter
    expect(post.likes_counter).to eq(1)
  end
end
