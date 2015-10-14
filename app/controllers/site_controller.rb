class SiteController < ApplicationController
  def index
    @photos = Photo.all.sample(9)
    @stores = Store.all.sample(3)
  end
end
