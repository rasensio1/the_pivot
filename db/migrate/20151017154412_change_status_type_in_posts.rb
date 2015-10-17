class ChangeStatusTypeInPosts < ActiveRecord::Migration
  def change
    remove_column :photos, :status
    add_column :photos, :active, :boolean, default: true
  end
end
