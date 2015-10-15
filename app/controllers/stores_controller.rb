class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    store = Store.new(store_params)

    if store.save
      flash[:success] = "Store successfully created!"
      redirect_to edit_admin_store_path(store)
    else
      flash[:warning] = "Failed"
      redirect_to new_store_path
    end
  end

  def show
    @store = Store.find(params[:id])
    @photos = @store.photos.where(status: 0).paginate(page: params[:page])
  end

  private
    def store_params
      params.require(:store).permit(:name, :tagline, :user_id)
    end
end
