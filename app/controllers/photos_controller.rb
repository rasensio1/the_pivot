class PhotosController < ApplicationController
  def index
    @photos = Photo.paginate(page: params[:page])
  end

  def show
    @photo = Photo.find(params[:id])
  end
end
