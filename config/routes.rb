Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'pages#home'
  # get '/welcome', to: 'guests#welcome'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'messengers#contact_form'
  get 'about', to: 'pages#about'
  get 'cgu', to: 'pages#cgu'
  get 'chart', to: 'pages#chart'
  get 'under_construction', to: redirect('/under_construction.html')

  resources :users, only: %I[index show edit update] do
    resources :comments, only: %I[create]
    resources :messages, only: %I[create]
    resources :trips, only: %I[new create]
    member do
      get "get_premium"
    end
  end


end
