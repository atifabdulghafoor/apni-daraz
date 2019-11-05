# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products
  resources :categories
  resources :products do
    resources :reviews
  end
  resources :reviews do
    resources :reviews
  end
  devise_for :users
end