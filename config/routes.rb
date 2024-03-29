# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products
  resources :categories

  concern :reviewable do
    resources :reviews
  end

  resources :products, concerns: :reviewable
  resources :reviews, concerns: :reviewable
  
  post 'categories_list' => "categories#categories_list", as: :categories_list

  devise_for :users
end