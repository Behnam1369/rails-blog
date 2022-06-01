require 'rails_helper'

RSpec.describe 'Requesting "/user": ', type: :request do
  it 'should return a response with status code 200.' do
    get '/users'
    expect(response).to have_http_status(200)
  end

  it 'should return a response that is a template of "users/index"' do
    get '/users'
    expect(response).to render_template('users/index')
  end

  it 'should return a text containing "List of Users:"' do
    get '/users'
    expect(response.body).to include('List of Users:')
  end
end

RSpec.describe 'Requesting "/user/5": ', type: :request do
  it 'should return a response with status code 200.' do
    get '/users/5'
    expect(response).to have_http_status(200)
  end

  it 'should return a response that is a template of "users/show"' do
    get '/users/5'
    expect(response).to render_template('users/show')
  end

  it 'should return a text containing "List of Users:"' do
    get '/users/5'
    expect(response.body).to include('User 5 Profile')
  end
end
