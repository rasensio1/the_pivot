class Admin::BaseController < ApplicationController

  def require_shop_admin
    byebug
    authorization_error unless current_user.shop.id == params[:id]
  end
end
