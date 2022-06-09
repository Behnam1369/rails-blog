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
end
