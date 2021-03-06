Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'pages#home'
  # get '/welcome', to: 'guests#welcome'
  get 'about', to: 'pages#about'
  get 'chart', to: 'pages#chart'
  get 'cgu', to: 'pages#cgu'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'messengers#contact_form'
  get 'under_construction', to: redirect('/under_construction.html')
  get 'welcome', to: 'pages#welcome'

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  resources :users, only: %I[index show edit update] do
    resources :comments, only: %I[create update]
    resources :messages, only: %I[create]
    resources :trips, only: %I[new create]
    resources :orders, only: %I[show create] do
      resources :payments, only: %I[new create]
    end
    member do
      get "moderate"
    end
  end

  resources :plans, only: %I(show create)




end
