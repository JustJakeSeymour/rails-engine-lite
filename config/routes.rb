Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "/api/v1/merchants/items"
      end
      resources :items, except: [:new, :edit] do
        resources :merchant, only: [:index], controller: "/api/v1/items/merchant"
      end
      delete "items", to: "items#delete"
    end
  end
end
