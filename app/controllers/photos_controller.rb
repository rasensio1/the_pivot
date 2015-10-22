class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
    if !@photo.active?
      flash[:warning] = "Sorry, but the photo you're looking for isn't available."
      redirect_to photos_path
    end
  end

  def index
    @label = Category.label(filter_id)
    @photos = Photo.category_photos(filter_id).paginate(page: params[:page])
    @categories = Category.all.sample(8)
  end
end
