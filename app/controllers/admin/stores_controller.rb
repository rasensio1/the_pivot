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
    store = current_store
    store.update(store_params)
    flash[:success] = "#{store.name} has been updated!"

    redirect_to correct_admin_page(store, params)
  end


  private

  def store_params
    params.require(:store).permit(:name, :tagline, :active)
  end

  def current_store
    Store.find_by(slug: params[:store_name])
  end

  def correct_admin_page(store, params)
    return god_dashboard_path if store_status_changed?(params)
    admin_store_path(store.slug)
  end

  def store_status_changed?(params)
    !!params[:store][:active]
  end
end
