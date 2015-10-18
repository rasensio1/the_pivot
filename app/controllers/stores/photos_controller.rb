class Stores::PhotosController < ApplicationController

  def index
    @store =  Store.find_by(slug: params[:store_name])
    @photos = @store.photos.active.cat_filter(filter_id).paginate(page: params[:page])
    @categories = @store.photos.map(&:category).uniq
  end
end
