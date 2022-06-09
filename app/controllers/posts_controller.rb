class PostsController < ApplicationController
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
    if @post.save
      flash[:success] = 'Post saved successfully'
      redirect_to '/posts/new'
    else
      flash.now[:error] = 'Error: Question could not be saved'
      render :new, locals: { post: }
    end
  end

  def update
    @post = Post.find(params['id'])
    @post['title'] = params[:post][:title]
    @post['text'] = params[:post][:text]
    if @post.save
      flash[:success] = 'Post saved successfully'
      redirect_to '/posts/new'
    else
      flash.now[:error] = 'Error: Question could not be saved'
      render :new, locals: { post: }
    end
  end

  skip_before_action :verify_authenticity_token
  def like_toggle
    @post = Post.find(params['id'])
    if Like.where(post: @post, author: current_user).empty?
      like = Like.new(post: @post, author: current_user)
      like.save
    else
      like = Like.where(post: @post, author: current_user)
      like.destroy_all
    end
  end
end
