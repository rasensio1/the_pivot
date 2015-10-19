class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @label = Category.label(filter_id)
    @photos = Photo.category_photos(filter_id).paginate(page: params[:page])
    @categories = Category.all
  end
end
