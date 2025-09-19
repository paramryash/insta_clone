# frozen_string_literal: true

Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'

  devise_for :accounts, controllers: {
    registrations: 'accounts/registrations'
  }

  get "/dashboard" => "accounts#index"
  get "show/:username" => "accounts#show", as: :show

  resources :accounts, only: %i[index show edit update], param: :username do
    post "follow", to: "accounts#follow"
  end

  resources :posts, only: %i[new create show destroy] do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy] do
      member do
        get :toggle_replies
      end
    end
  end

  root "home#index"
end
