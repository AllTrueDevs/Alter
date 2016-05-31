Rails.application.routes.draw do
  get 'tag/destroy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :page, only: :home
  get '/about', to: 'page#about', as: :about

  root to: 'page#home'

  resources :requests do
    member do
      get :check
      get :decline
      get :upvote
      get :downvote
    end
    collection do
      get :unchecked
      get :search
    end
  end
  get '/refresh_counters', to: 'requests#refresh_counters', as: :refresh_counters

  resources :messages do
    collection do
      get :select
      get :dialog
      post :new_private
      post :new_post
      post :remove_selected
      get :mark_as_read
      get :clear
    end
  end
  resources :attachments do
    member do
      get :download
    end
  end

  resources :articles, except: [:index, :edit, :new, :show]
  get '/news', to: 'articles#index', as: :news
  get '/news/:id/:url', to: 'articles#show', as: :show_article
  get '/news/:id/:url/edit', to: 'articles#edit', as: :edit_article
  get '/news/new', to: 'articles#new', as: :new_article

  resources :user_tag, only: :destroy

  devise_for :users, controllers: {
    registrations: 'registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :decisions, only: [:index, :show, :create] do
    member do
      post :accept
      post :deny
      post :partly
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
      get :select_requests
      get :statistic
      get :detach_social_link
      get :upvote
      get :downvote
      get :activity
    end
    collection do
      patch :change_password
      get :search
      get :update_cities_np_data
    end
  end

  get '/id:id', to: 'users#show', as: :user
end
