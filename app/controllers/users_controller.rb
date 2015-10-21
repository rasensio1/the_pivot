require 'find'
require 'uri'

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    sleep(10)
    file = Cloudinary::Uploader.multi("download", :format => 'zip')['url'] 

     $image_ids.each do |id|
       Cloudinary::Api.update(id, :tags => "hi")
     end

    redirect_to file
  end

  def export
    data = JSON.parse(params.first.first)
    ids = data.select{ |k,_| k =~ /\A\d*\z/}.map{ |_,v| v}.map(&:to_i)
    valid_ids = ids.select{ |num| current_user.photos.pluck(:id).include?(num) }

   $image_ids = valid_ids.map do |id|  
     Photo.find(id).file.file.public_id
   end

   $image_ids.each do |id|
     Cloudinary::Api.update(id, :tags => "download")
   end
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update_attributes(user_params)
    current_user.save!
    redirect_to profile_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end
