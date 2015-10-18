class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @photos = Photo.where(active: true).paginate(page: params[:page])
    @categories = Category.sample(5)
  end

end
