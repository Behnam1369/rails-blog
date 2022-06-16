require 'rails_helper'

RSpec.describe 'Post index page test', type: :feature do
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

    Post.create(author: @first_user, title: 'Second Post', text: 'This is my second post')
    Post.create(author: @first_user, title: 'Third Post', text: 'This is my third post')
    Post.create(author: @first_user, title: 'Fourth Post', text: 'This is my fourth post')
    Post.create(author: @first_user, title: 'Fifth Post', text: 'This is my fifth post')
    Post.create(author: @first_user, title: 'Sixth Post', text: 'This is my sixth post')
    @post = Post.last
    5.times do
      Comment.create(author: @second_user, post: @post, text: 'Hi Tom!!')
    end
    5.times do
      Like.create(author: @second_user, post: @post)
    end
  end

  before :each do
    visit root_path
    fill_in 'user_email', with: 'victorperaltagomez@gmail.com'
    fill_in 'user_password', with: '121212'
    click_button 'Log in'
    visit "/users/#{User.first.id}/posts"
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'The profile picture of the user should be visible.' do
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

  it 'The user\'s posts title should be visible' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.posts.last
    expect(page).to have_content(post.title)
  end

  it 'The user\'s posts body should be visible' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.posts.last
    expect(page).to have_content(post.text)
  end

  it 'The user\'s posts comment should be visible' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.posts.last
    comment = post.comments.last
    expect(page).to have_content(comment.text)
  end

  it 'Can see how many comments a post has' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.posts.last
    expect(page.has_link?(href: "/users/#{user.id}/posts/#{post.id}",
                          text: "Comments: #{post.comments_counter}")).to be true
  end

  it 'Can see how many likes a post has' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.posts.last
    expect(page.has_link?(href: "/users/#{user.id}/posts/#{post.id}",
                          text: "Likes: #{post.likes_counter}")).to be true
  end

  it 'pagination section should be visible when we have more than one page.' do
    link_to_second_page = find('div.pagination ul li:eq(2)')
    expect(link_to_second_page).to have_text('2')
  end

  it 'When click on a post, it redirects to that post\'s show page' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.last_3_posts[1]
    find_link(href: "/users/#{user.id}/posts/#{post.id}").click
    expect(page).to have_content(post.title) && have_content(post.text)
  end
end
