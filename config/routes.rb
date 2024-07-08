# frozen_string_literal: true

Rails.application.routes.draw do
  mount Avo::Engine, at: Avo.configuration.root_path
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  # Defines the root path route ("/")
  # root "articles#index"
end
