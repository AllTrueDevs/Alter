Rails.application.routes.draw do

  resources :requests
  get 'home/index'
  root 'home#index'
  devise_for :users, controllers: { registrations: "registrations" }
  get '/id:id', to: 'users#show', as: :user
  get '/users', to: 'users#index', as: :users
  get '/id:id/requests', to: 'requests#index', as: :user_requests
  resources :categories, only: [:index, :destroy, :create]
end
