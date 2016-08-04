Rails.application.routes.draw do
  resources :line_items
  resources :carts
  root "products#index"
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
