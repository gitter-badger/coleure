Rails.application.routes.draw do
  resources :palettes, only: [:index, :show, :edit]
  resources :colors,   only: [:create, :destroy]
  resources :users,    only: [:new, :create, :edit, :update]

  root to: "palettes#new"
end
