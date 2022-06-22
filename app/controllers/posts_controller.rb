class PostsController < ApplicationController
  # load_and_authorize_resource

  def index
    params
  end

  def show
    params
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params['id'])
  end

  def create
    @post = Post.create(post_params)
    @post.author = current_user
    # @post.comments_counter = 0
    # @post.likes_counter = 0
    if @post.save
      redirect_to "/users/#{@post.author.id}/posts/#{@post.id}"
    else
      flash[:error] = 'Error: post could not be saved'
      render :new
    end
  end

  def update
    @post = Post.find(params['id'])
    @post['title'] = params[:post][:title]
    @post['description'] = params[:post][:description]
    # @post['comments_counter'] = 0 if params[:post][:comments_counter].nil?
    # @post['likes_counter'] = 0 if params[:post][:likes_counter].nil?

    if @post.save
      redirect_to "/users/#{@post.author.id}/posts/#{params['id']}"
    else
      flash.now[:error] = 'Error: Post could not be saved'
      render :edit
    end
  end

  def delete
    @post = Post.find(params['id'])

    if @post.destroy
      redirect_to "/users/#{@post.author.id}/posts",
                  allow_other_host: true,
                  notice: 'Post deleted'
    else
      flash.now[:error] = 'Error: Post could not be deleted'
      # render :show
    end
  end

  skip_before_action :verify_authenticity_token
  def like_toggle
    @post = Post.find(params['id'])
    like = Like.where(post: @post, author: current_user)
    if like.empty?
      like = Like.new(post: @post, author: current_user)
      like.save
    else
      like = Like.where(post: @post, author: current_user).first
      like.destroy
    end
    @post.save
    redirect_to "/users/#{params['user_id']}/posts/#{params['id']}"
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
