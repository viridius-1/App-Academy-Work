Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # resources :users 

  #routes for users prefix 
  get 'users', to: 'users#index', as: 'users'  
  post 'users', to: 'users#create'
  #routes for user prefix 
  get 'users/:id', to: 'users#show', as: 'user'
  patch 'users/:id', to: 'users#update'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
  #route for new_user prefix 
  get 'users/new', to: 'users#new', as: 'new_user'
  #route for edit_user prefix 
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'

  # Defines the root path route ("/")
  # root "articles#index"
end
