class ChangeImageUrlInPhotosToSeedName < ActiveRecord::Migration
  def change
    rename_column :photos, :image_url, :seed_name
  end
end
