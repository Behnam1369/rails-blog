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
    @post = Post.create(params.require(:post).permit(:title, :text))
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0
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
    @post['text'] = params[:post][:text]
    @post['comments_counter'] = 0 if params[:post][:comments_counter].nil?
    @post['likes_counter'] = 0 if params[:post][:likes_counter].nil?

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
      render :show
    end
  end

  skip_before_action :verify_authenticity_token
  def like_toggle
    @post = Post.find(params['id'])
    if Like.where(post: @post, author: current_user).empty?
      like = Like.new(post: @post, author: current_user)
      like.save
      @post.likes_counter = @post.likes_counter.nil? ? 1 : @post.likes_counter + 1
    else
      like = Like.where(post: @post, author: current_user)
      like.destroy_all
      @post.likes_counter -= 1
    end
    @post.save
    redirect_to "/users/#{params['user_id']}/posts/#{params['id']}"
  end

  def post_params
    params.require(:post).permit!
  end
end
