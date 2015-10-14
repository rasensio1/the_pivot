class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, autosave: true
  has_many :items, through: :order_items

  def customer_name
    User.find(user_id).name
  end

  def total
    order_items.inject(0) do |total, order_item|
      total += order_item.quantity * Photo.find(order_item.photo_id).standard_price
    end
  end

  def status
    Status.find(status_id).name
  end
end
