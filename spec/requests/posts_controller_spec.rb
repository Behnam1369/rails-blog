require 'rails_helper'

RSpec.describe 'Requesting "/users/1/posts": ', type: :request do
  user = User.new(name: 'user1', posts_counter: 0)
  user.save

  post = Post.new(title: 'New post', text: 'post body', author: user, comments_counter: 0, likes_counter: 0)
  post.save

  it 'should return a response with status code 200.' do
    get "/users/#{user.id}/posts"
    expect(response).to have_http_status(200)
  end

  it 'should return a response that is a template of "posts/index"' do
    get "/users/#{user.id}/posts"
    expect(response).to render_template('posts/index')
  end

  it 'should return a text containing title of the post' do
    get "/users/#{user.id}/posts"
    expect(response.body).to include(post.title)
  end
end

RSpec.describe 'Requesting "/users/1/posts/1": ', type: :request do
  user = User.new(name: 'user1', posts_counter: 0)
  user.save

  post = Post.new(title: 'New post', text: 'post body', author: user, comments_counter: 0, likes_counter: 0)
  post.save

  it 'should return a response with status code 200.' do
    get "/users/#{user.id}/posts/#{post.id}"
    expect(response).to have_http_status(200)
  end

  it 'should return a response that is a template of "posts/show"' do
    get "/users/#{user.id}/posts/#{post.id}"
    expect(response).to render_template('posts/show')
  end

  it 'should return a text containing title of post and name of user' do
    get "/users/#{user.id}/posts/#{post.id}"
    expect(response.body).to include(post.title) && include(user.name)
  end
end
