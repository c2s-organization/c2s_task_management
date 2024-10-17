require 'sidekiq/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web => '/sidekiq'

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
