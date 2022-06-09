class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(params.require(:comment).permit(:text))
    @comment.author = current_user
    @comment.post = Post.find(params['post_id'])
    if @comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to "/users/#{params['user_id']}/posts/#{params['post_id']}"
    else
      flash.now[:error] = 'Error: Comment could not be saved'
      render :new, locals: { post: }
    end
  end
end
