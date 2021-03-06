class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :cart, :current_admin?, :store_owner?

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && !current_user.stores.nil?
  end

  def current_store
    Store.find_by(slug: params[:store_name])
  end

  def authorization_error
    render file: "/public/404_authorization.html", layout: false, status: 404
  end

  def require_user
    authorization_error unless current_user
  end

  def filter_id 
    params[:filter] || "0"
  end

  def set_flash_errors(object)
    object.errors.messages.each do |attr, msg|
      flash[:danger] ||= ""
      flash[:danger] += "#{attr.to_s.humanize} - #{msg.first.humanize} <br>"
    end
  end

  def photos_for_sale
    Photo.where(active: true).joins(:store).where(stores: {active: true})
  end
end
