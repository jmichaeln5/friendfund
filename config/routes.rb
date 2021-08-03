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
  end
  resources :friend_requests, only: [:show, :update, :destroy]

  # resources :users do
  #   resources :friend_requests, shallow: true
  # end

  resources :friendships

### Only for Admin Create
  resources :friend_requests, only: :create # Only used form admin_friend_request
  get '/admin_friend_request', to: 'friend_requests#admin_friend_request', as: 'admin_friend_request'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
