Rails.application.routes.draw do
  resources :ratings, only: [:create, :new, :index]
  resources :picks, only: [:create, :new, :index]
  resources :items, only: [:create, :index, :new, :show]
  resources :users, only: [:create, :new]
  resources :lists, only: [:show]

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  get 'search', to: 'search#search', as: 'search'
  get '/privacy', to: "home#privacy", as: :privacy
  get '/tos', to: "home#tos", as: :tos
  root to: "home#index"
end
