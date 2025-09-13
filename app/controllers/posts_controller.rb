class PostsController < ApplicationController
  before_action :authenticate_account!  


  
  def new
    @post= Post.new
  end

  def create
    @post= Post.new(post_params)
  @post.active = true   

     @post.account_id = current_account.id 

    if @post.save
      redirect_to dashboard_path,notice: "Post create! "

    else
      redirect_to new_post_path
    end
  end

def show
  @post = Post.find(params[:id])
  @comment = Comment.new

  if params[:reply_to].present?
    @comment.body = "@#{params[:reply_to]} "
  end
end

def destroy
  @post = Post.find(params[:id]) 
  @post.destroy

  respond_to do |format|
    format.html { redirect_to account_path(current_account.username) if account_signed_in? }
    format.turbo_stream
  end

end

private
def post_params 
  params.require(:post).permit(:image, :description)
end

end
