Rails.application.routes.draw do

  resources :requests
  get 'home/index'
  root 'home#index'
  devise_for :users, controllers: { registrations: "registrations"}

end
