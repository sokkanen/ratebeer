# frozen_string_literal: true

Rails.application.routes.draw do
  root 'breweries#index'
  resources :beers
  resources :breweries
  resources :ratings, only: %i[index new create destroy]
end
