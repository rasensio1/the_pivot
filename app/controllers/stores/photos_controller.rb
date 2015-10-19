class Stores::PhotosController < ApplicationController

  def index
    @store =  Store.find_by(slug: params[:store_name])
    @photos = @store.category_photos(filter_id).paginate(page: params[:page])
    @categories = categories(@store)
  end

  def categories(store)
    if !store.photos.joins(:categories).empty?
      Category.joins(:photos).where(photos: {store_id: store.id}).uniq
    end
  end
end
