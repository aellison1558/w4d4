Rails.application.routes.draw do
  root to: 'bands#index'

  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:index]
  end

  resources :albums, only: [:show, :new, :create, :destroy] do
    resources :tracks, only: [:index]
  end

  resources :tracks, only: [:show, :new, :create, :destroy]
end
