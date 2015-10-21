class God::DashboardController < Admin::BaseController
  def index
    @stores = Store.all.order(name: :desc)
  end
end
