require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'behnam')

  it 'User without a posts_counter shouldn\'t be valid.' do
    expect(user).to_not be_valid
  end

  it 'User with a posts_counter should be valid.' do
    user.posts_counter = 0
    expect(user).to be_valid
  end

  it 'posts_counter of user should be integer.' do
    user.posts_counter = 0.5
    expect(user).to_not be_valid
  end

  it 'last 3 post for a new user should be empty.' do
    expect(user.last_3_posts.length).to eq(0)
  end

  it 'last 3 post for a user shouldn\'t return more than 3 post.' do
    user = User.new(name: 'user1', posts_counter: 0)
    user.save

    5.times do
      Post.new(title: 'something', text: 'something', author: user, comments_counter: 0, likes_counter: 0).save
    end
    expect(user.last_3_posts.length).to eq(3)
  end
end
