class Admin::PhotosController < Admin::BaseController
  before_action :require_shop_admin

  def index
    @photos = Photo.all
  end

  def new
    @store = Store.find_by(slug: params[:store_name])
    @photo = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def create
    photo = new_photo

    if photo.save
      PhotoCreator.create_relations(photo, params)
      flash[:success] = "'#{photo.title}' has been added!"
      redirect_to admin_store_path(photo.store.slug)
    else
      set_flash_errors(photo)
      redirect_to :back
    end
  end

  def update
    if my_photo.update_attributes(photo_params)
      PhotoCreator.edit_relationships(my_photo, params)
      flash[:success] = "'#{my_photo.title}' has been updated!"
      redirect_to admin_store_path(my_photo.store.slug)
    else
      set_flash_errors(Photo.update(my_photo.id, photo_params))
      redirect_to :back
    end
  end

  def destroy
    photo = my_photo
    if photo.watermark?
      photo.store.update(watermark_id: nil)
      photo.destroy
    else
      photo.update(active: false)
    end
    flash[:info] = "'#{photo.title}' has been removed."
    redirect_to :back
  end

  private

  def set_flash_errors(object)
    object.errors.messages.each do |attr, msg|
      flash[:danger] ||= ""
      flash[:danger] += "#{attr.to_s.humanize} - #{msg.first.humanize} <br>"
    end
  end

  def convert_currency_fields(photo_params)
    photo_params[:standard_price] = cents(photo_params[:standard_price])
    photo_params[:commercial_price] = cents(photo_params[:commercial_price])
    photo_params
  end

  def cents(dollars)
    number = dollars.gsub(/[$,.]/, '').to_i
    dollars.include?('.') ? number : number * 100
  end

  def my_photo
    Photo.find(params[:id])
  end

  def new_photo
    if params[:photo][:watermark] == "true"
      PhotoCreator.watermark_photo(params)
    else
      PhotoCreator.photo(photo_params)
    end
  end

  def photo_params
    convert_currency_fields(
    params.require(:photo).permit(
      :title,
      :description,
      :standard_price,
      :commercial_price,
      :file,
      :created_at,
      :updated_at,
      :store_id)
    )
  end
end
