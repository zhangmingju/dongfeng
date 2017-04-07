require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords:'users/passwords',
    omniauth_callbacks:'users/omniauth_callbacks'
  }
  root to: "welcomes#index"
  get 'user/root' => "welcomes#index"

  resources :articles, only: [:show,:index]
  resources :categories, only: [:index,:show]

  resources :users, only: [:show,:update,:index]
  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
    resources :categories
    resources :images
    resources :articles do 
      collection do 
        post :preview
      end
      member do 
        get :publish
      end
    end
  end
end

