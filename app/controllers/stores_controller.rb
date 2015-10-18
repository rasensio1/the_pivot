class StoresController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def new
    @store = Store.new
  end

  def create
    store = Store.new(store_params)

    if store.save
      StoreAdmin.create(user_id: current_user.id, store_id: store.id)
      flash[:success] = "Store successfully created!"
      redirect_to admin_store_path(store.slug)
    else
      flash[:warning] = "Failed"
      redirect_to new_store_path
    end
  end

  private
    def store_params
      params.require(:store).permit(:name, :tagline, :user_id)
    end
end
