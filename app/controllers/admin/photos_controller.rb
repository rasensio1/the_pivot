class Admin::PhotosController < Admin::BaseController
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    photo = Photo.new(photo_params)

    if photo.save
      flash[:notice] = "#{photo.title} photo has been added!"
      redirect_to edit_admin_store_path(current_user.store)
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)

    redirect_to admin_photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(
      :title,
      :description,
      :standard_price,
      :commercial_price,
      :image_url,
      :created_at,
      :updated_at,
      :store_id
    )
  end
end
