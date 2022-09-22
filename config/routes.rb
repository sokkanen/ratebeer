Rails.application.routes.draw do
  root 'breweries#index'
  resources :beers
  resources :breweries
  get 'ratings', to: 'ratings#index'
end
