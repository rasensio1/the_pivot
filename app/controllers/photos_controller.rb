class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @photos = Photo.active.cat_filter(params[:filter]).paginate(page: params[:page])
    @categories = Category.all.sample(5)
  end

end
