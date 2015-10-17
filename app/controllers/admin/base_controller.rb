class Admin::BaseController < ApplicationController

  def require_shop_admin
    authorization_error unless current_user.stores.pluck(:slug).include?(params[:store_name])
  end
end
