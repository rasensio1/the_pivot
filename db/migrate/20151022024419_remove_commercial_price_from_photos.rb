class RemoveCommercialPriceFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :commercial_price
  end
end
