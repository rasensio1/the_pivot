Rails.application.routes.draw do
  root to: "site#index"

  post "/download", to: "users#export"
  post "/getfiles", to: "users#getfiles"
  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"
  get "/profile", to: "users#show"
  patch "/profile", to: "users#update"
  get "/profile/edit", to: "users#edit"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace "admin" do
    resources :orders, only: [:show, :update]
    get ":store_name/edit", as: :store, to: "stores#edit"
    resources :stores, path: ":store_name", only: [:update]
    resources :store_admins, only: [:create]
  end

  namespace "god" do
    get "dashboard", to: "dashboard#index"
  end

  namespace "stores", as: "store", path: ":store_name" do
    resources :photos, only: [:index]
  end

  scope ":store_name", as: "store", module: "admin" do
    resources :photos, only: [:new, :edit, :update, :create, :destroy]
  end

  scope ":store_name", as: "store" do
    resources :photos, only: [:show]
  end
  
  resources :photos, only: [:index]

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"
  delete "/cart_items", to: "cart_items#destroy"

  resources :orders, only: [:create, :index, :show]
  resources :stores, only: [:new, :create, :show]
end
