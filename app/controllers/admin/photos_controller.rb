class Admin::PhotosController < Admin::BaseController
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.category_id = params[:photo][:category].to_i
    if @photo.save
      redirect_to meal_path(@photo)
      flash.now[:notice] = "#{@photo.name} created"
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
    params.require(:photo).permit(:name,
                                 :description,
                                 :price,
                                 :image_url,
                                 :status)
  end
end
