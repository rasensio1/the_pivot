class Admin::BaseController < ApplicationController

  def require_shop_admin
    authorization_error unless store_admin? || platform_admin?
  end

  def require_platform_admin
    authorization_error unless platform_admin?
  end

  private

  def store_admin?
    current_user && current_user.stores.pluck(:slug).include?(params[:store_name])
  end

  def platform_admin?
    current_user && current_user.platform_admin?
  end
end
