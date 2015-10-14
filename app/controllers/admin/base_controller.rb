class Admin::BaseController < ApplicationController

  def require_shop_admin
    authorization_error unless current_user.store.id == params[:id].to_i
  end
end
