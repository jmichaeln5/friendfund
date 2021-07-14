Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/about'

  devise_for :users

  get '/dashboard', to: 'dashboard#show', as: 'dashboard'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
