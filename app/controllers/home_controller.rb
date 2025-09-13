# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to show_path(current_account.username) if account_signed_in?
  end
end
