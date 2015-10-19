class RemoveCategoryIdFromPhoto < ActiveRecord::Migration
  def change
    remove_column :photos, :category_id
  end
end
