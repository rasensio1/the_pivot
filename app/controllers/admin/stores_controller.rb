class Admin::StoresController < Admin::BaseController
  before_filter :require_shop_admin, only: [:edit]
  def edit
  end
end
