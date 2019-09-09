Rails.application.routes.draw do
  resources :items
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'levels', to: 'levels#index'
  get 'levels/:id', to: 'levels#show'
  post 'levels', to: 'levels#create'
  put 'levels', to: 'levels#update'

#   root 'home#index'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  post 'signup', to: 'users#create', as: 'signup'
  post 'update', to: 'users#update', as: 'update'
  post 'delete', to: 'users#destroy', as: 'delete'
  
  post 'authenticate', to: 'authentication#authenticate'
end
