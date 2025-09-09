# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :authenticate_account!

def create
  @account = Account.find(params[:account_id])
  current_account.follow(@account)

  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to accounts_path }
  end
end

def destroy
  @account = Account.find(params[:account_id])
  current_account.unfollow(@account)

  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to accounts_path }
  end
end

end
