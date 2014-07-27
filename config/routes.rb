Rails.application.routes.draw do
  resources :palettes, only: [:show, :edit]
  resources :colors,   only: [:create, :destroy]

  root to: "palettes#new"
end
