class OrdersController < ApplicationController

  def create
    if current_user
      redirect_to orders_path
    else
      flash[:warning] = "Sign In to complete your order, Dinners almost ready!"
      redirect_to login_path
    end
  end

  def show
    
  end

end
