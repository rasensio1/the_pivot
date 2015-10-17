class Admin::BaseController < ApplicationController

  def require_shop_admin
    authorization_error unless current_user.stores.pluck(:id).include?(params[:id].to_i)
  end
end
