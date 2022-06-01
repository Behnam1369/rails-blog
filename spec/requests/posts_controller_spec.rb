require 'rails_helper'

RSpec.describe 'Requesting "/users/5/posts": ', type: :request do
  it 'should return a response with status code 200.' do
    get '/users/5/posts'
    expect(response).to have_http_status(200)
  end

  it 'should return a response that is a template of "posts/index"' do
    get '/users/5/posts'
    expect(response).to render_template('posts/index')
  end

  it 'should return a text containing "List of Users:"' do
    get '/users/5/posts'
    expect(response.body).to include('List of posts written by users 5')
  end
end

RSpec.describe 'Requesting "/users/5/posts/118": ', type: :request do
  it 'should return a response with status code 200.' do
    get '/users/5/posts/118'
    expect(response).to have_http_status(200)
  end

  it 'should return a response that is a template of "posts/show"' do
    get '/users/5/posts/118'
    expect(response).to render_template('posts/show')
  end

  it 'should return a text containing "List of Users:"' do
    get '/users/5/posts/118'
    expect(response.body).to include('Post 118 (author: user5 )')
  end
end
