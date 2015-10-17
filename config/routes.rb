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

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"
  delete "/cart_items", to: "cart_items#destroy"

  resources :bullshit

  resources :photos, only: [:index, :show]
  resources :orders, only: [:create, :index, :show]
  resources :stores, only: [:new, :create, :show]

  namespace "admin" do
    resources :orders, only: [:show, :update]
    resource :dashboard, only: [:show]
    get ":store_name/edit", as: :store, to: "stores#edit"
    resources :stores, path: ":store_name", only: [:update]
    resources :store_admins, only: [:create]
  end

  scope ":store_name" do
    get "/photos", as: :store_photos, to: "stores/photos#index"
    post "/photos", to: "admin/photos#create"
    get "/photos/new", as: :new_store_photo, to: "admin/photos#new"
    get "/photos/:id/edit", as: :edit_store_photo, to: "admin/photos#edit"
    get "/photos/:id", as: :store_photo, to: "photos#show"
    patch "/photos/:id", to: "admin/photos#update"
    delete "/photos/:id", to: "admin/photos#destroy"
  end

end
