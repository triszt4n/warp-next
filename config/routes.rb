Rails.application.routes.draw do
  resources :albums do
    member do
      delete :delete_image
      post :add_image
      get :image
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

  resources :circles do
    member do
      get :details
    end
  end
  resources :memberships do
    member do
      post :accept
      post :demote
      post :promote
    end
  end

  #We need this so old links are still working after update
  #But with this routing we can make short urls in the future
  #
  scope ActiveStorage.routes_prefix do
    get '/blobs/redirect/:signed_id/*filename', to: 'secure_blobs#show'
  end

  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/auth/oauth/callback', to: 'sessions#create'
  root 'home#home'
end
