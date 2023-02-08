Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "merchants/find", to: "/api/v1/merchants/find#index"
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "/api/v1/merchants/items"
      end

      get "items/find", to: "/api/v1/items/find#index"
      get "items/find_all", to: "/api/v1/items/find_all#index"
      resources :items, except: [:new, :edit] do
        resources :merchant, only: [:index], controller: "/api/v1/items/merchant"
      end
      delete "items", to: "items#delete"
    end
  end
end
