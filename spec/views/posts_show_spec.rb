require 'rails_helper'

RSpec.describe 'User show page test', type: :feature do
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

    5.times do
      Post.create(author: @first_user, title: 'First Post', text: 'This is my first post', comments_counter: 0,
                  likes_counter: 0)
    end
    post = Post.first

    5.times do
      Comment.create(author: @second_user, post:, text: 'Hi Tom!!')
    end
  end

  before :each do
    visit root_path
    fill_in 'user_email', with: 'victorperaltagomez@gmail.com'
    fill_in 'user_password', with: '121212'
    click_button 'Log in'
    visit "/users/#{User.first.id}/posts/#{Post.first.id}"
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'The post title should be visible.' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content(post.title)
  end

  it 'The name of the author of the post should be visible.' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content(post.author.name)
  end

  it 'Number of comments for the post should be visible.' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  it 'Number of Likes for the post should be visible.' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end

  it 'The post body should be visible.' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content(post.text)
  end

  it 'The username of every commentor should be visible' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    post.comments.all do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'The username of every commentor should be visible' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    post.comments.all do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
