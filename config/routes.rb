# frozen_string_literal: true

Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  root 'breweries#index'

  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: %i[index new create destroy]
  resource :session, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'
  
end
