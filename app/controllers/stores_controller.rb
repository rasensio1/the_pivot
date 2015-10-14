class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    store = Store.new(store_params)

    if store.save
      flash[:success] = "Store successfully created!"
      byebug
      redirect_to store_admin_dashboard_path(store)
    else
      flash[:warning] = "Failed"
      redirect_to new_store_path
    end
  end

  private
    def store_params
      params.require(:store).permit(:name, :tagline)
    end
end
