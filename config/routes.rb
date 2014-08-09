Rails.application.routes.draw do
  get 'users/new'

  get 'sessions/new'

  resources :palettes, only: [:index, :show, :edit]
  resources :colors,   only: [:create, :destroy]

  root to: "palettes#new"
end
