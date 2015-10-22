class SiteController < ApplicationController
  def index
    @photos = photos_for_sale.sample(9)
    @stores = Store.where(active: true).all.sample(3)
    @categories = Category.all.sample(4)
  end

end
