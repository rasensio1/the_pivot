class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @label = Category.label(filter_id)
    @photos = Photo.active.cat_filter(filter_id).paginate(page: params[:page])
    @categories = Category.all.sample(5)
  end

  private
    def filter_id 
      params[:filter]
    end

end
