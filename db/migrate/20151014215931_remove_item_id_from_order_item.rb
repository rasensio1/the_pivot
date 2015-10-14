class RemoveItemIdFromOrderItem < ActiveRecord::Migration
  def change
    remove_column :order_items, :item_id
  end
end
