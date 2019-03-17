Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/levels', to: 'levels#index'
  get '/levels/:id', to: 'levels#show'
  post '/levels', to: 'levels#create'
  put '/levels', to: 'levels#update'
end
