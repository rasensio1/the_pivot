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
      flash[:success] = "#{photo.title} photo has been added!"
      redirect_to edit_admin_store_path(photo.store_id)
    else
      render :new
    end
  end

  def edit
    @photo = my_photo 
  end

  def update
    photo = Photo.find(params[:id])
    photo.update(photo_params)
    flash[:success] = "#{photo.title} photo has been updated!"
    redirect_to edit_admin_store_path(current_user.store)
  end

  def destroy
    my_photo.update(status: 1)
      flash[:info] = "#{my_photo.title} photo has been removed"
    redirect_to edit_admin_store_path(current_user.store)
  end

  private

  def my_photo
    Photo.find(params[:photo_id])
  end

  def photo_params
    params.require(:photo).permit(
      :title,
      :description,
      :standard_price,
      :commercial_price,
      :file,
      :created_at,
      :updated_at,
      :store_id
    )
  end
end
