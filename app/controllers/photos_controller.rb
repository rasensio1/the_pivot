class PhotosController < ApplicationController
  def index
    @photos = Photo.where(status: 0).paginate(page: params[:page])
  end

  def show
    @photo = Photo.find(params[:id])
  end
end
