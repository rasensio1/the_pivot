class Admin::StoreAdminsController < Admin::BaseController 

  def create
    user = User.find_by(email: params[:user][:email])
    user_exists?(user) or return

    new_admin = StoreAdmin.create(user_id: user.id, store_id: params[:user][:store_id])
    set_flash_errors(new_admin) unless new_admin.save

    redirect_to :back
  end

  def require_shop_and_owner
    authorization_error unless current_user.store
  end

  private

  def user_exists?(user)
    if !user
      flash[:warning] = "Sorry, but #{params[:user][:email]} is not a Photo's Ready user."
      redirect_to :back and return
    end
    return true
  end
end
