class Admin::BaseController < ApplicationController

  def require_shop_admin
    authorization_error unless store_admin?
  end

  private

  def store_admin?
    current_user && current_user.stores.pluck(:slug).include?(params[:store_name]) 
  end
end
