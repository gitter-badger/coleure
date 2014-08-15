Rails.application.routes.draw do
  root to: "palettes#new"

  get :login,  to: "sessions#new"
  get :logout, to: "sessions#destroy"

  resources :sessions, only: [:create]
  resources :palettes, only: [:index, :show, :edit]
  resources :colors,   only: [:create, :destroy]
  resources :users,    only: [:new, :create, :show, :edit, :update]
end
