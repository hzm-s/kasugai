Rails.application.routes.draw do
  root to: 'pages#index'

  resources :sign_ups, only: [:new, :create]
  get '/sign_ups/ready', to: 'sign_ups#ready', as: :ready_sign_up
  get '/email_callback/:token', to: 'email_callbacks#create', as: :email_callback

  resource :home, only: [:show]

  # ui
  resources :pages, only: [:index, :show]
end
