class PhotosController < ApplicationController
  def index
    @photos = Store.find_by(slug: params[:store_name]).photos.where(status: 0).paginate(page: params[:page])
  end

  def show
    @photo = Photo.find(params[:id])
  end
  
  def all
    @photos = Photo.where(status: 0).paginate(page: params[:page])
  end
end
