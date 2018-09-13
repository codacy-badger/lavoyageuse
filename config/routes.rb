Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # get '/welcome', to: 'guests#welcome'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'messengers#contact_form'
  get 'about', to: 'pages#about'
end
