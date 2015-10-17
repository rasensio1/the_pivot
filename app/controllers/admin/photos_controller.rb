class Admin::PhotosController < Admin::BaseController

  def index
    @photos = Photo.all
  end

  def create
    photo = Photo.new(photo_params)

    if photo.save
      flash[:success] = "#{photo.title} photo has been added!"
      redirect_to admin_store_path(photo.store.slug)
    else
      render :new
    end
  end

  def update
    my_photo.update(photo_params)
    flash[:success] = "#{my_photo.title} photo has been updated!"
    redirect_to admin_store_path(current_user.store.slug)
  end

  def destroy
    my_photo.update(status: 1)
    flash[:info] = "#{my_photo.title} photo has been removed"
    redirect_to admin_store_path(current_user.store.slug)
  end

  private

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
      :store_id)
    )
  end
end
