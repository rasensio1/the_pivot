class Admin::StoresController < Admin::BaseController
  before_filter :require_shop_admin, only: [:edit]

  def edit
    @user = User.new
    @store = current_store
    @photo = Photo.new
    @watermark_demo = Photo.all.sample
    @photos = current_store.photos.where(active: true)
    @store_admins = current_store.users
  end

  def update
    store = Store.find(params[:store][:id])
    store.update_attributes(store_params)
    flash[:success] = "#{store.name} has been updated!"

    redirect_to admin_store_path(store.slug)
  end

  private
  def store_params
    params.require(:store).permit(:name, :tagline)
  end

  def current_store
    Store.find_by(slug: params[:store_name])
  end
end
