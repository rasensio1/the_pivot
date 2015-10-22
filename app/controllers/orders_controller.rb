class OrdersController < ApplicationController

  def create
    if current_user
      create_order
      empty_cart
      flash[:success] = "Your order is complete. You can download full resolution versions of any photograph you've purchased by logging into your account and using the Download Center below."
      redirect_to profile_path
    else
      flash[:warning] = "Please sign in to complete your order."
      redirect_to login_path
    end
  end

  def index
    current_user ? @orders = current_user.orders : authorization_error
  end

  def show
    @order = Order.find(params[:id])
  end

  private

    def add_order_items(order)
      cart.photos.each do |cart_item|
        order.order_items.new(photo: cart_item.photo, quantity: cart_item.quantity, sale_amount: cart_item.photo.standard_price)
      end
    end

    def create_order
      order = current_user.orders.new
      add_order_items(order)
      order.status_id = 1
      order.save
    end

    def empty_cart
      session[:cart] = {}
      cart.empty
    end
end
