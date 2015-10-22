class AddSaleAmountToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :sale_amount, :integer
  end
end
