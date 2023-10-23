# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "welcome#index"
  # resources :welcome, only: [:index]

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  get "/register", to: "users#new", as: :register
  resources :users, only: [:create, :show] do 
    get "/discover" => "search#index"
    get "/movies" => "search#show"
    get "/movies/:id" => "details#show"
    get "/movies/:id/new" => "parties#new"
    post "/movies/:id/create" => "parties#create"
  end
end