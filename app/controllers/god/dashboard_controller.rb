class God::DashboardController < Admin::BaseController
  before_action :require_platform_admin

  def index
    @stores = Store.all.order(name: :desc)
  end
end
