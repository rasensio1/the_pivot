class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @photos = Photo.where(active: true).paginate(page: params[:page])
  end

end
