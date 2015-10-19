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
    byebug
    photo = Photo.new(photo_params)

    if photo.save
      flash[:success] = "#{photo.title} photo has been added!"
      redirect_to admin_store_path(photo.store.slug)
    else
      set_flash_errors(photo)
      redirect_to new_store_photo_path(photo.store.slug)
    end
  end

  def update
    if my_photo.update_attributes(photo_params)
      flash[:success] = "#{my_photo.title} photo has been updated!"
      redirect_to admin_store_path(my_photo.store.slug)
    else
      set_flash_errors(Photo.update(my_photo.id, photo_params))
      redirect_to :back
    end
  end

  def destroy
    my_photo.update(active: false)
    flash[:info] = "#{my_photo.title} photo has been removed"
    redirect_to admin_store_path(current_user.store.slug)
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
      :store_id,
      :category_id)
    )
  end
end
