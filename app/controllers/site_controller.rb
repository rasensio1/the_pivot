class SiteController < ApplicationController
  def index
    @photos = Photo.all.sample(9)
    @stores = Store.all.sample(3)
    @categories = Category.all.sample(4)
  end
end
