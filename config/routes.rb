Rails.application.routes.draw do
  resources :favorites
  resources :ratings
  resources :users
  
  resources :levels

  get 'levels/:id/rating', to: 'levels#rating'
  
  post 'authenticate', to: 'authentication#authenticate'
  get 'health', to: 'health#index'
end
