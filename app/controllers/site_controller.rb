class SiteController < ApplicationController
  def index
    @photos = Photo.all
  end
end
