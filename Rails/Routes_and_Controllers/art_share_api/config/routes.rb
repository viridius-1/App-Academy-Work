Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # resources :users 

  #routes for users prefix 
  # get 'users', to: 'users#index', as: 'users'  
  # post 'users', to: 'users#create'
  #routes for user prefix 
  # get 'users/:id', to: 'users#show', as: 'user'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'

  #USERS
  #routes to users controller 
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :users do 
    get 'collection_list', on: :member #route to show the collection list of a user 
  end 

  #ARTWORKS
  #routes to artworks controller 
  resources :artworks, only: [:show, :create, :update, :destroy]
  #artwork member routes 
  resources :artworks do 
    get 'collection_list', on: :member #route to show the collection list of a artwork
    patch 'favorite', on: :member #route for a user to mark their artwork as a favorite
  end 
  #route to get all the artworks of a user. this returns all the artworks a user owns and all the artworks that have been shared with that user. this will allow a GET request to /users/:user_id/artworks
  resources :users do 
    resources :artworks, only: [:index]
  end 

  #COLLECTIONS
  #routes to collections controller 
  resources :collections, only: [:index, :show, :create]

  #ARTWORKSHARES
  #routes to artwork_shares controller 
  resources :artwork_shares, only: [:index, :show, :create, :destroy]
  resources :artwork_shares do 
    patch 'favorite', on: :member #route for a user to mark artwork that has been shared with them as a favorite
  end 

  #COMMENTS
  #routes to comments controller 
  resources :comments, only: [:create, :destroy, :index]
end
