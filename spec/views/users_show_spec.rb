require 'rails_helper'

RSpec.describe 'User show page test', type: :feature do
  before :all do
    @first_user ||= User.create(
      name: 'Tom',
      email: 'victorperaltagomez@gmail.com',
      password: '121212',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    @second_user ||= User.create(
      name: 'Lilly',
      email: '123@123.com',
      password: '121212',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    Post.create(author: @first_user, title: 'First Post', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: @first_user, title: 'Second Post', text: 'This is my second post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: @first_user, title: 'Third Post', text: 'This is my third post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: @first_user, title: 'Fourth Post', text: 'This is my fourth post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: @first_user, title: 'Fifth Post', text: 'This is my fifth post', comments_counter: 0,
                likes_counter: 0)
    @post = Post.first
    6.times do
      Comment.create(author: @second_user, post: @post, text: 'Hi Tom!!')
    end
  end

  before :each do
    visit root_path
    fill_in 'user_email', with: 'victorperaltagomez@gmail.com'
    fill_in 'user_password', with: '121212'
    click_button 'Log in'
    visit "/users/#{User.first.id}"
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'The profile picture od the user should be visible.' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    expect(page.has_xpath?("//img[@src = '#{user.photo}' ]"))
  end

  it 'The username of the user should be visible.' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    expect(page.has_link?(user.name)).to be true
  end

  it 'The number of posts that the user has written should be visible.' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it 'The user\'s bio should be visible.' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    expect(page).to have_content(user.bio) && have_content('Bio')
  end

  it 'The first 3 posts of the user should be visible' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    user.last_3_posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'A button that resirects to the user\'s posts should be available.' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    expect(page.has_link?('See all posts', href: "/users/#{user.id}/posts")).to be true
  end

  it 'By clicking on a user\'s post, it should be redirected to that post\'s show page' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.last_3_posts[1]
    find_link(href: "/users/#{user.id}/posts/#{post.id}").click
    expect(page).to have_content(post.title) && have_content(post.text)
  end

  it 'By clicking on the "see all posts", it should be redirected to the user\'s post\'s index page' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    find_link('See all posts', href: "/users/#{user.id}/posts").click
    expect(page).to have_current_path("/users/#{user.id}/posts")
  end
end
