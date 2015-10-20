class RemoveSeedNameFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :seed_name
  end
end
