Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/about'

  # devise_for :users
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations'
   }

  devise_scope :user do
    get 'sign_up', to: 'users/registrations#new'
    get 'sign_in', to: 'users/sessions#new'
    delete 'signout', to: 'users/sessions#destroy'
  end

  get '/dashboard', to: 'dashboard#show', as: 'dashboard'

  resources :users do
    resources :friend_requests, only: [:index, :new, :create]
    get '/friends', to: 'friendships#index', as: 'friends'
  end
  # resources :friend_requests, only: [:create, :index, :show, :update, :destroy]
  resources :friend_requests
  resources :friendships


  resources :notifications do
    collection do
      post :mark_all_as_read
    end
  end

  post '/notifications/:id/mark_as_read', to: 'notifications#mark_as_read', as: 'mark_as_read'
  get '/all_notifications', to: 'notifications#all_notifications', as: 'all_notifications'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
