Rails.application.routes.draw do
  root to: 'home#show'

  get '/sign_up/:token', to: 'users#create', as: :verify_sign_up
  resources :sign_ups, param: :token, only: [:new, :create]

  get '/sign_in/:token', to: 'sessions#create', as: :sign_in
  resources :sign_ins, only: [:new, :create]

  resource :home, only: [:show]

  # ui
  resources :pages, only: [:index, :show]
end
