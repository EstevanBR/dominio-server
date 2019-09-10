Rails.application.routes.draw do
  resources :users
  
  resources :levels
  
  post 'authenticate', to: 'authentication#authenticate'
  get 'health', to: 'health#index'
end
