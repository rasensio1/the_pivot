class Admin::OrderItemsController < Admin::BaseController
  before_action :require_shop_admin

  def index
    @store = Store.find_by(slug: params[:store_name])
    @photos = @store.photos
  end

end
