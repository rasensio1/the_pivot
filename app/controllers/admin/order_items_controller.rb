class Admin::OrdersItemsController < Admin::BaseController

  def index
    @store = Store.find(params[:id])
  end

end
