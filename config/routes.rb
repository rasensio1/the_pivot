Rails.application.routes.draw do
  root to: "site#index"

  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"
  get "/profile", to: "users#show"
  patch "/profile", to: "users#update"
  get "/profile/edit", to: "users#edit"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace "admin" do
    resources :photos, except: [:show, :indes, :new, :edit]
    resources :orders, only: [:show, :update]
    resource :dashboard, only: [:show]
    resources :stores, only: [:edit, :update]
  end

  scope ":store_name", as: "store" do
    resources :photos, only: [:show, :index, :new, :edit]
  end

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"
  delete "/cart_items", to: "cart_items#destroy"

  get "/photos", to: "photos#all"
  resources :orders, only: [:create, :index, :show]
  resources :stores, only: [:new, :create, :show]
end
