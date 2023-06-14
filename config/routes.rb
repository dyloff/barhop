Rails.application.routes.draw do
  devise_for :users

  root "crawls#home"

  resources :users, only: [:index] do
    member do
      post :follow
      post :unfollow
    end
  end

  resources :crawls, only: [:home, :index, :new, :create, :show ] do
    resources :reviews, only: [:new, :create]
    resources :shared_withs, only: [:create]
    resources :crawlbars, only: [:create]
  end

  resources :users, only: [:destroy]
  get 'dashboard', to: 'users#dashboard'
  # delete "dashboard", to: "users#destroy"
  # get 'generate', to: 'crawls#generate'
  get 'friends', to: 'users#friends'

  resources :bar, only: [] do
    resources :favourites, only: [:new, :create]
  end

  resources :reviews, only: [:destroy]
end
