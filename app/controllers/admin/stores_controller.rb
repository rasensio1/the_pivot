class Admin::StoresController < Admin::BaseController
  before_filter :require_shop_admin, only: [:edit]
  def edit
    @store = current_user.store
    @photos = current_user.store.photos.where(status: 0)
  end
end
