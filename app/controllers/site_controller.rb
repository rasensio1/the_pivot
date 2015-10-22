class SiteController < ApplicationController
  def index
    @photos = photos_for_sale.sort_by{|photo| photo.sales_quantity}.reverse.first(9)
    @stores = Store.where(active: true).sort_by{|store| store.sales_quantity}.reverse.first(3)
    @categories = Category.all.sample(4)
  end

end
