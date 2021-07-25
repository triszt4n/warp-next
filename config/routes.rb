Rails.application.routes.draw do
  resources :users
  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/auth/oauth/callback', to: 'sessions#create'
  root 'users#index'
end
