# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products
  devise_for :users
end
