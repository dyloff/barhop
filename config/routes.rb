Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  devise_for :users
  root "crawls#home"

  resources :users, only: [:dashboard] do
    resources :favourites, only: [:new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :crawls, only: [:home, :index, :new, :create ] do
    resources :reviews, only: [:new, :create]
  end
end
