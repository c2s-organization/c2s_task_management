Rails.application.routes.draw do
  resources :tasks

  namespace :api do
    resources :scrapings, only: [:update]
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#login'
  get 'register', to: 'sessions#new_register'
  post 'register', to: 'sessions#register'
  delete 'logout', to: 'sessions#destroy'

  root 'sessions#new'
end
