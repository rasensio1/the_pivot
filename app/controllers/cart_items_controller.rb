class CartItemsController < ApplicationController
  def index
    @cart_items = cart.photos
  end

  def create
    photo = Photo.find(params[:photo_id])
    cart.add_item(photo)
    session[:cart] = cart.data
    redirect_to :back
  end

  def update
    cart.update_quantity(params[:id], params[:quantity])
    remove_and_render_flash(params[:id]) if cart.data[params[:id]] == 0
    redirect_to :back
  end

  def destroy
    remove_and_render_flash(params[:id])
    redirect_to :back
  end


  private

  def remove_and_render_flash(id)
    photo = Photo.find_by(id: id)
    link = "<a href='/photos/#{params[:id]}'>#{photo.title}</a>"
    flash[:success] = %[Successfully removed #{link} from your cart.]

    cart.remove_from_cart(photo)
  end

end
