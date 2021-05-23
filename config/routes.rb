Rails.application.routes.draw do
  resources :sectors
  get "/sectors/categories/:category", to: "sectors#index", as: "sectors_categories"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :mountains, :andinists, :ascents, :routes
  get "uncategorized/index"
  get "uncategorized/nomenclatura"
  get "uncategorized/about"
  root to: "uncategorized#index"
end
