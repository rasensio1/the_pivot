class AddWatermarkToStores < ActiveRecord::Migration
  def change
    add_column :stores, :watermark_id, :integer
  end
end
