Rails.application.routes.draw do
  resources :albums do
    member do
      delete :delete_image
      post :add_image
    end
    collection do
      get :myalbums
    end
  end
  resources :users do
    collection do
      get :adminpage
    end
  end
  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/auth/oauth/callback', to: 'sessions#create'
  root 'home#home'
end
