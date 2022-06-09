class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(params.require(:comment).permit(:text))
    @comment.author = current_user
    post = Post.find(params['post_id'])
    @comment.post = post
    if @comment.save
      flash[:success] = 'Comment saved successfully'
      post.comments_counter = post.comments_counter.nil? ? 1 : post.comments_counter + 1
      post.save
      redirect_to "/users/#{params['user_id']}/posts/#{params['post_id']}"
    else
      flash.now[:error] = 'Error: Comment could not be saved'
      render :new, locals: { post: }
    end
  end
end
