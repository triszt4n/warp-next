Rails.application.routes.draw do

  resources :albums do
    member do
      delete :delete_image
      post :add_image
    end
  end
  
  resources :participations, except: [:new]
  get 'events/:event_id/register', to: 'participations#new', as: 'register_to_event'

  resources :rents
  resources :items
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }

  resources :users
  resources :event_types
  resources :events
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'posts#index'
  get '/about', to: 'posts#about', as: 'about'
end
