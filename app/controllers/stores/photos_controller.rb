class Stores::PhotosController < Admin::BaseController
  before_action :inactive_store_access

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

  private

  def inactive_store_access
    authorization_error unless platform_admin? || store_admin? || current_store.active?
  end
end
