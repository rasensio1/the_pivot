Rails.application.routes.draw do
  root to: "site#index"
  get "/newindex", to: "site#show"

  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"
  get "/profile", to: "users#show"
  patch "/profile", to: "users#update"
  get "/profile/edit", to: "users#edit"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace "admin" do
    resources :photos, except: [:show]
    resources :orders, only: [:index, :show, :update]
    resource :dashboard, only: [:show]   
    resources :stores, only: [:edit]
  end

  namespace :menu do
    resources :categories, only: [:show]
  end

  resources :photos, only: [:index, :show]
  
  post "/menu", to: "location#check_zipcode", as: :zipcode
  get "menu/:id", to: "menu/categories#show"

  post "/cart_items", to: "cart_items#create"
  put "/cart_items", to: "cart_items#update"
  get "/cart", to: "cart_items#index"

  delete "/cart_items", to: "cart_items#destroy"

  resources :orders, only: [:create, :index, :show]

  resources :stores, only: [:new, :create]
end
