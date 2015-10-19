class Stores::PhotosController < ApplicationController

  def index
    @store =  Store.find_by(slug: params[:store_name])
    @photos = @store.category_photos(filter_id).paginate(page: params[:page])
    @categories = categories(@store)
  end

  def categories(store)
    if store.photos.map(&:categories).select{ |collection| !collection.empty? }.empty?
      nil
    else
      store.photos.map(&:categories).map(&:to_a).flatten
    end
  end
end
