class AddPlatformAdminColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :platform_admin, :boolean, default: false
  end
end
