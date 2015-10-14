class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to profile_path
      flash[:success] = "YeeHaw! #{@user.name} is signed in!"
    else
      redirect_to login_path
      flash[:danger] = "Sorry m'friend. You go HUNGRY!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
