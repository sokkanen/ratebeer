Rails.application.routes.draw do
  root 'breweries#index'
  resources :beers
  resources :breweries
  get 'ratings', to: 'ratings#index'
  get 'ratings/new', to:'ratings#new'

  post 'ratings', to: 'ratings#create'
end
