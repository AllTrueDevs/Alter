Rails.application.routes.draw do

  resources :requests
  get 'home/index'
  root 'home#index'
  devise_for :users, controllers: { registrations: "registrations" }
  get '/id:id', to: 'users#show', as: :user
  get '/users', to: 'users#index', as: :users
  get '/id:id/requests', to: 'requests#index', as: :user_requests
  resources :categories, only: [:index, :destroy, :create, :update]
  resources :decisions, only: [:index, :show, :create]
  get '/decisions/:id/accept', to: 'decisions#accept', as: :accept
  get '/decisions/:id/deny', to: 'decisions#deny', as: :deny
  post '/decisions/:id/partly', to: 'decisions#partly', as: :partly
  post '/decisions/:id', to: 'decisions#show'
  get '/notifications/clean', to: 'notifications#clean', as: :clean
  resources :notifications, only: [:index, :show, :destroy]
  get 'requests/:id/destroy' => 'requests#destroy', as: :destroy
  get '/id:id/change_ban_status', to: 'users#change_ban_status', as: :ban
  get '/id:id/change_moder_status', to: 'users#change_moder_status', as: :moder
  get '/user/id:id/admin_login', to: 'users#admin_login', as: :admin_login
  get '/id:id/requests/actual', to: 'users#actual_requests', as: :user_actual_requests
  get '/id:id/requests/archived', to: 'users#archived_requests', as: :user_archived_requests
  get '/id:id/statistic', to: 'users#statistic', as: :user_statistic

end
