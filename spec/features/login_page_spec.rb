require 'rails_helper'

RSpec.describe 'Login page test', type: :feature do
  before :all do
    @first_user ||= User.create(
      name: 'Tom',
      photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
      bio: 'A teacher from Mexico',
      email: 'victorperaltagomez@gmail.com',
      password: '121212',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    @second_user ||= User.create(
      name: 'Lilly',
      photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
      bio: 'A teacher from Poland',
      email: '123@123.com',
      password: '121212',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    Post.create(author: @first_user, title: 'First Post', text: 'This is my first post')
    Post.create(author: @first_user, title: 'Second Post', text: 'This is my second post')
    Post.create(author: @first_user, title: 'Third Post', text: 'This is my third post')
    Post.create(author: @first_user, title: 'Fourth Post', text: 'This is my fourth post')
    Post.create(author: @first_user, title: 'Fifth Post', text: 'This is my fifth post')
    post = Post.first
    Comment.create(author: @second_user, post: post, text: 'Hi Tom!!')
    Comment.create(author: @second_user, post: post, text: 'Hi Tom!!')
    Comment.create(author: @second_user, post: post, text: 'Hi Tom!!')
    Comment.create(author: @second_user, post: post, text: 'Hi Tom!!')
    Comment.create(author: @second_user, post: post, text: 'Hi Tom!!')
    Comment.create(author: @second_user, post: post, text: 'Hi Tom!!')
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  before :each do
    visit root_path
  end
  
  it 'See username and password inputs, and Log in button' do
    visit root_path
    expect(has_field?('user_email') && has_field?('user_password') && has_button?('Log in')).to be true
  end

  it 'Detail error with empty credentials' do
    fill_in 'user_email', with: ''
    fill_in 'user_password', with: ''
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Detail error with wrong credentials' do
    fill_in 'user_email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Correct Log in and redirect to HomePage' do
    fill_in 'user_email', with: 'victorperaltagomez@gmail.com'
    fill_in 'user_password', with: '121212'
    click_button 'Log in'
    expect(page).to have_current_path(root_path)
  end

end
