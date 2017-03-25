require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords:'users/passwords',
    omniauth_callbacks:'users/omniauth_callbacks'
  }
  root to: "welcomes#index"
  get 'admin' => 'admin/homes#index'

  resources :users, only: [:show,:update,:index]
  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
    resources :categories
    resources :articles do 
      collection do 
        post :preview
      end
    end
  end
end

