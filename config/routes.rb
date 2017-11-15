Rails.application.routes.draw do
  root to: 'home#show'

  get '/sign_up/:token', to: 'users#create', as: :verify_sign_up
  resources :sign_ups, param: :token, only: [:new, :create]

  get '/sign_in/:token', to: 'sessions#create', as: :sign_in
  resources :sign_ins, only: [:new, :create]

  delete '/sign_out', to: 'sessions#destroy', as: :sign_out

  get '/home', to: 'home#show', as: :home

  get '/profile/edit', to: 'profile#edit', as: :edit_profile
  patch '/profile', to: 'profile#update', as: :profile

  resources :projects, only: [:index, :new, :create, :show]

  scope '/projects/:project_id', as: :project, module: :project do
    resources :issues
    resources :bookmarked_issues, only: [:index, :create, :destroy]
    resources :members, only: [:index, :new, :create]
  end

  scope '/issues/:issue_id', as: :issue, module: :issue do
    resource :priority, only: [:update]
    resources :comments, only: [:index, :create, :destroy]
  end

  # ui
  resources :pages, only: [:index, :show]
end
