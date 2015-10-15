class CartItemsController < ApplicationController
  def index
    @cart_items = cart.photos
  end

  def create
    photo = Photo.find(params[:photo_id])
    if cart.add_item(photo)
      flash[:success] = "Successfully added '#{photo.title}' to your cart."
    else
      flash[:warning] = "The photo '#{photo.title}' is already in your cart."
    end
    session[:cart] = cart.data
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
