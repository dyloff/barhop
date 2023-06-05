Rails.application.routes.draw do
  get 'favourites/new'
  get 'favourites/create'
  get 'users/dashboard'
  get 'shared_withs/share'
  get 'shared_withs/confirm'
  get 'crawls/home'
  get 'crawls/index'
  get 'crawls/new'
  get 'crawls/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
