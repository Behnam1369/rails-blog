require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'behnam')
  user.save
  post = Post.new(text: 'post body', author: user)

  it 'Post without a title shouldn\'t be valid.' do
    post.comments_counter = 0
    post.likes_counter = 0
    expect(post).to_not be_valid
  end

  it 'Post with a title should be valid.' do
    post.title = 'Post title'
    expect(post).to be_valid
  end

  it 'Post with a title longer than 250 characters shouldn\'t be valid.' do
    title = 'Post title' * 26
    post.title = title
    expect(post).to_not be_valid
  end

  it 'Post without a comments_counter shouldn\'t be valid.' do
    post.title = 'Post title'
    post.comments_counter = nil
    expect(post).to_not be_valid
  end

  it 'Post with a comments_counter shouldn\'t be valid.' do
    post.comments_counter = 0
    expect(post).to be_valid
  end

  it 'comments_counter of post should be integer.' do
    post.comments_counter = 0.5
    expect(post).to_not be_valid
  end

  it 'Post without a likes_counter shouldn\'t be valid.' do
    post.comments_counter = 0
    post.likes_counter = nil
    expect(post).to_not be_valid
  end

  it 'Post with a likes_counter shouldn\'t be valid.' do
    post.likes_counter = 0
    expect(post).to be_valid
  end

  it 'likes_counter of post should be integer.' do
    post.likes_counter = 0.5
    expect(post).to_not be_valid
  end

  it 'update_post_counter method should increment counter in author instance' do
    post.likes_counter = 0
    post.update_post_counter
    expect(post.author.posts_counter).to eq(1)
  end

  it 'last 5 comments for a new user should be empty.' do
    expect(post.last_5_comments.length).to eq(0)
  end

  it 'last 5 comments for a post shouldn\'t return more than 3 comments.' do
    user = User.new(name: 'user1', posts_counter: 0)
    user.save

    post = Post.new(title: 'New post', text: 'post body', author: user, comments_counter: 0, likes_counter: 0)
    post.save

    10.times do
      Comment.new(author: user, post:, text: 'something').save
    end
    expect(post.last_5_comments.length).to eq(5)
  end
end
