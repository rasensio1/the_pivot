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
    resources :photos, except: [:show]
    resources :orders, only: [:index, :show, :update]
    resource :dashboard, only: [:show]
    resources :stores, only: [:edit]
  end

  namespace :menu do
    resources :categories, only: [:show]
  end

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"
  delete "/cart_items", to: "cart_items#destroy"

  resources :photos, only: [:index, :show]
  resources :orders, only: [:create, :index, :show]
  resources :stores, only: [:new, :create]
end
