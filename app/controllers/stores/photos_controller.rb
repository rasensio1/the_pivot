class Stores::PhotosController < ApplicationController

  def index
    @store =  Store.find_by(slug: params[:store_name])
    @photos = @store.photos.where(active: true).paginate(page: params[:page])
  end

end
