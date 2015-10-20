class UsersController < ApplicationController
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

  def export

    folder = "tmp/zip/files"
    zipfile_name = "tmp/zip/test_files.zip"
    file_names = ["hello.txt", "yeah.txt"]

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      Zip.continue_on_exists_proc = true
        file_names.each do |filename|
          zipfile.add(filename, folder + "/" + filename)
        end
       zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
    end

    redirect_to profile_path
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
