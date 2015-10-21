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
    clear_tmp
    send_file(
          "#{Rails.root}/tmp/images.zip",
            filename: "images.zip",
            type: "zip"
            )
  end

  def export

    data = JSON.parse(params.first.first)
    ids = data.select{ |k,_| k =~ /\A\d*\z/}.map{ |_,v| v}.map(&:to_i)
    valid_ids = ids.select{ |num| current_user.photos.pluck(:id).include?(num) }

   image_urls = valid_ids.map do |id|  
     Photo.find(id).file_url(:full)
   end

   image_urls.each do |url|
      tail = tail(url) 
      open("#{Rails.root}/tmp/#{tail}", 'wb') do |file|
          file << open(url).read
      end
   end

    folder = "#{Rails.root}/tmp/"
    zipfile_name = folder + "images.zip"
    file_paths = Find.find(Rails.root.join('tmp')).select { |p| /.*\.jpg$/ =~ p }

    file_names = file_paths.map { |path| tail(path) }

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        file_names.each do |filename|
          zipfile.add(filename, folder + filename)
        end
    end

  end

  def tail(url)
     URI(url).path.split('/').last
  end

  def clear_tmp
    file_paths = Find.find(Rails.root.join('tmp').to_s).select { |p| /.*\.jpg$/ =~ p }
    FileUtils.rm file_paths
    #FileUtils.rm ["#{Rails.root.join('tmp/images.zip')}"]
  end

  def kill_zip
    FileUtils.rm ["#{Rails.root.join('tmp/images.zip')}"]
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
