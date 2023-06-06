Rails.application.routes.draw do
  devise_for :users
  root "crawls#home"

  resources :users, only: [:dashboard] do
    resources :favourites, only: [:new, :create]
    resources :reviews, only: [:destroy]
  end

  resources :crawls, only: [:home, :index, :new, :create ] do
    resources :reviews, only: [:new, :create]
  end
end
