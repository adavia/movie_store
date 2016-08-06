Rails.application.routes.draw do
  get "admin" => "admin#index"

  controller :sessions do
    get    "login" => :new
    post   "login" => :create
    delete "logout" => :destroy
  end

  resources :users
  resources :orders, only:[:new, :create]
  resources :line_items, only:[:create]
  resources :carts, only:[:show, :destroy]
  root "products#index"
  resources :products, only:[:index, :new, :create] do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
