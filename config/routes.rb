# frozen_string_literal: true

Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  devise_for :accounts

  get "/dashboard" => "accounts#index"
  get "show/:username" => "accounts#show", as: :show

  resources :posts, only: %i[new create show destroy ]
resources :accounts, only: %i[index show edit update], param: :username


  resources :posts do
    resources :likes, only: %i[create destroy]
  end

  resources :accounts do
    post "follow", to: "accounts#follow"
  end

# resources :accounts do
#   resource :follow, only: [:create, :destroy] ,as: :follow
# end

resources :posts do
  resources :comments, only: [:create, :destroy]
end

# resources :posts do
#     post "comments", to: "comments#create"
# end



  root "home#index"
end
