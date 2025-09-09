# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_account!

  def create
    @post = Post.find(params[:post_id])
    current_account.likes.create(post: @post)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referrer || root_path }
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_account.likes.find(params[:id]).destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referrer || root_path }
    end
  end
end
