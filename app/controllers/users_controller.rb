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
    send_file(
          "#{Rails.root}/tmp/zip/images.zip",
            filename: "your_images.zip",
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
     tail = URI(url).path.split('/').last
      open("tmp/images/#{tail}", 'wb') do |file|
          file << open(url).read
      end
   end

    folder = "tmp/images"
    zipfile_name = "tmp/zip/images.zip"
    files = `ls tmp/images`
    file_names = files.chomp.split("\n")

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      Zip.continue_on_exists_proc = true
        file_names.each do |filename|
          zipfile.add(filename, folder + "/" + filename)
        end
       zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
    end

    clear_tmp

  end

  def clear_tmp
    `rm -rf tmp/images/*`
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
