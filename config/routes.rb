Rails.application.routes.draw do

  resources :requests
  get 'home/index'
  root 'home#index'
  devise_for :users, controllers: { registrations: "registrations" }
  get '/id:id', to: 'users#show', as: :user
  get '/users', to: 'users#index', as: :users
  get '/id:id/requests', to: 'requests#index', as: :user_requests
  resources :categories, only: [:index, :destroy, :create]
  resources :decisions, only: [:index, :show, :create]
  get '/decisions/:id/accept', to: 'decisions#accept', as: :accept
  get '/decisions/:id/deny', to: 'decisions#deny', as: :deny
  resources :notifications, only: [:index, :show, :destroy]
  get 'requests/:id/destroy' => 'requests#destroy', as: :destroy
  post '/id:id/ban', to: 'users#ban', as: :ban
  post '/id:id/unban', to: 'users#unban', as: :unban
  post '/id:id/moder', to: 'users#moder', as: :moder
  post '/id:id/unmoder', to: 'users#unmoder', as: :unmoder
  get '/id:id/requests/actual', to: 'users#actual_requests', as: :user_actual_requests
  get '/id:id/requests/archived', to: 'users#archived_requests', as: :user_archived_requests
end
