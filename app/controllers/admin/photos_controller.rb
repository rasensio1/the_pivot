class Admin::PhotosController < Admin::BaseController
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    # @photo.category_id = params[:photo][:category].to_i

    if @photo.save
      flash[:notice] = "#{@photo.title} photo has been added!"
      redirect_to profile_path
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
      :descriptio,
      :standard_pric,
      :commercial_pric,
      :image_ur,
      :created_at,
      :updated_at,
      :store_i
    )
  end
end
