# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  root 'breweries#index'
  resources :beers
  resources :breweries
  resources :ratings, only: %i[index new create destroy]

  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
end
