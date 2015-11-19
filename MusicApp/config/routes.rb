Rails.application.routes.draw do
  root to: 'bands#index'

  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:show, :index, :create, :edit, :update, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:show, :index, :create, :edit, :update, :destroy]
end
