class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  attr_accessor :image_ids

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      flash[:danger] = "Ya screwed something up parter, try again!"
      redirect_to sign_up_path
    end
  end

  def show
    if current_user
      @orders = current_user.orders
      @user_photos = current_user.photos
      @admin_stores = current_user.stores
    else
      redirect_to "/404"
    end
  end

  def getfiles
    image_ids.each do |id|
      Cloudinary::Api.update(id, :tags => "download")
    end
    file = Cloudinary::Uploader.multi("download", :format => 'zip')['url'] 
    image_ids.each do |id|
      Cloudinary::Api.update(id, :tags => "hi")
    end
    redirect_to file
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update_attributes(user_params)
    set_flash_errors(current_user) unless current_user.save 
    redirect_to profile_path(current_user)
  end

  private

  def image_ids
    data = params[:photos].select { |_,v| v['title'] == "1"}
    ids = data.keys.map(&:to_i)
    
    valid_ids = ids.select{ |num| current_user.photos.pluck(:id).include?(num) }

    valid_ids.map do |id|  
      Photo.find(id).file.file.public_id
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end
