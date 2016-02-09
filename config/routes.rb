Rails.application.routes.draw do

  resources :home, only: :index

  root to: 'home#index'

  resources :requests

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :categories, only: [:index, :destroy, :create, :update]

  resources :decisions, only: [:index, :show, :create] do
    member do
      get :accept
      get :deny
      get :partly
    end
  end

  resources :notifications, only: [:index, :show, :destroy] do
    collection do
      get :clean
    end
  end

  resources :users, only: :index do
    member do
      get :change_ban_status, as: :ban
      get :change_moder_status, as: :moder
      get :admin_login
      get :actual_requests
      get :archived_requests
      get :statistic
    end
  end

  get '/id:id', to: 'users#show', as: :user

end
