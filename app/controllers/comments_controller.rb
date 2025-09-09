class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.account = current_account

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to account_path(@post.account.username) }
      end
    else
      respond_to do |format|
        format.turbo_stream { flash[:alert] = "Something went wrong ❌" }
        format.html { redirect_to account_path(@post.account.username) }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
