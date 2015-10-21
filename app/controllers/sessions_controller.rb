class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id

      redirect_to user_home_page(@user)
      flash[:success] = "YeeHaw! #{@user.name} is signed in!"
    else
      redirect_to `login_path`
      flash[:danger] = "Sorry m'friend. You go HUNGRY!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_home_page(user)
    return god_dashboard_path if user.platform_admin?
    profile_path
  end
end
