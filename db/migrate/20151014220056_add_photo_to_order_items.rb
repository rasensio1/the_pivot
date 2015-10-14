class AddPhotoToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :photo, index: true, foreign_key: true
  end
end
