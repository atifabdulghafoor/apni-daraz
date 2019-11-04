# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products
  resources :categories
  devise_for :users
end