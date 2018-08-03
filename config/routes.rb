Rails.application.routes.draw do
  get 'sessions/new'
  get 'home/index'
  root "home#index"

  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"
  get "home" => "home#index", as: "home"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
end