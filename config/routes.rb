Rails.application.routes.draw do
  resources :articles
  resources :sources
  resources :sectors
  get "/sectors/categories/:category", to: "sectors#index", as: "sectors_categories"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/mountains/:id/undo', to: 'mountains#undo', as: :undo
  resources :mountains, :andinists, :ascents, :routes

  get "uncategorized/index"
  get "uncategorized/nomenclatura"
  get "uncategorized/about"
  get "mountains_init", to: "mountains#index_init", as: "mountains_init"
  root to: "uncategorized#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
	}



end
