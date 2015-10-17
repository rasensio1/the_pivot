class Admin::StoresController < Admin::BaseController
  before_filter :require_shop_admin, only: [:edit]
  def edit
    @user = User.new
    @store = current_user.store
    @photos = current_user.store.photos.where(status: 0)
    @store_admins = current_user.store.users
  end

  def update
    store = Store.find(params[:id])
    store.update(store_params)
    flash[:success] = "#{store.name} has been updated!"
    redirect_to edit_admin_store_path(current_user.store)
  end

  private
  def store_params
    params.require(:store).permit(:name, :tagline)
  end
end
