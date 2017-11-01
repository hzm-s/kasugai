Rails.application.routes.draw do
  root to: 'pages#index'

  resources :sign_up_requests, only: [:new, :create]

  get '/sign_up/:token', to: 'sign_ups#create', as: :sign_up
  get '/sign_in/:token', to: 'sessions#create', as: :sign_in

  resource :home, only: [:show]

  # ui
  resources :pages, only: [:index, :show]
end
