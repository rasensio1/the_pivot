class Admin::StoreAdminsController < Admin::BaseController 
  def create
    new_admin = User.find_by(email: params[:user][:email])
    StoreAdmin.create(user_id: new_admin.id, store_id: current_user.store.id)
    redirect_to :back
  end

  def require_shop_and_owner
    authorization_error unless current_user.store
  end
end
