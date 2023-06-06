Rails.application.routes.draw do
  devise_for :users

  root "crawls#home"

  resources :crawls, only: [:home, :index, :new, :create, :show ] do
    resources :reviews, only: [:new, :create]
    resources :shared_withs, only: [:create]
    resources :crawlbars, only: [:create]
  end

  get 'dashboard', to: 'users#dashboard'

  resources :bar, only: [] do
    resources :favourites, only: [:new, :create]
  end

  resources :reviews, only: [:destroy]
end
