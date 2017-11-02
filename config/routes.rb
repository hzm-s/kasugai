Rails.application.routes.draw do
  root to: 'pages#index'

  resources :sign_ups, param: :token, only: [:new, :create] do
    get :verify, on: :member
  end

  resources :sign_ins, only: [:new, :create]

  get '/sign_in/:token', to: 'sessions#create', as: :sign_in

  resource :home, only: [:show]

  # ui
  resources :pages, only: [:index, :show]
end
