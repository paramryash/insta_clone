# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_account, only: [:show]

  def index
        @posts = Post.all.order(created_at: :desc)
    @accounts = Account.where.not(id: current_account.id)
    @comments= Comment.all
    #  @posts = Post.all.includes(:account, :comments)
      # @accounts = Account.all
      # @posts = Post.all.includes(:comments) 
  
        @reply_to = params[:reply_to]
        @post_id = params[:post_id]
  end

  def show
    @account = Account.find_by!(username: params[:username])
    @posts = @account.posts.active
  end

def update
  if @account.update(account_params)
    render :show
  else
    render :edit, status: :unprocessable_entity
  end
end



  def follow
    @account = Account.find(params[:account_id])

    if current_account.following?(@account)
      current_account.unfollow(@account)
    else
      current_account.follow(@account)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to account_path(@account.username) }
    end
  end

  private

  def set_account
    @account = Account.find_by(username: params[:username])
  end
end
