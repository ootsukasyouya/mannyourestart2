Rails.application.routes.draw do
  resources :labels
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'users#new'
  resources :tasks
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
