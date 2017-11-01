Rails.application.routes.draw do
  root to: 'pages#index'

  resources :sign_up_requests, only: [:new, :create]

  get '/sign_up/:token', to: 'sign_ups#create', as: :sign_ups

  resource :home, only: [:show]

  # ui
  resources :pages, only: [:index, :show]
end
