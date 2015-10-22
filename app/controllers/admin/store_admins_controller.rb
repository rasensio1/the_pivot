class Admin::StoreAdminsController < Admin::BaseController 

  def create
    user = User.find_by(email: params[:user][:email])

    if user 
      new_admin = StoreAdmin.create(user_id: new_admin.id, store_id: params[:user][:store_id])
      if new_admin.save
      end

    else
      flash[:warning] = "Sorry, but #{params[:user][:email]} is not a Photo's Ready user."
    end

    redirect_to :back
  end

  def require_shop_and_owner
    authorization_error unless current_user.store
  end
end
