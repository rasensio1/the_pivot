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

    input_filenames = ["https://s3-us-west-2.amazonaws.com/fordo/seo40.png"]
    zipfile_name = "/test_files.zip"

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        input_filenames.each do |filename|

           zipfile.add("my_image.png", url_list)

         end
       zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
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
