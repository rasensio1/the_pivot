class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, autosave: true
  has_many :items, through: :order_items

  def customer_name
    User.find(user_id).name
  end

  def total
    total_cents = order_items.inject(0) do |total, order_item|
      total += Photo.find(order_item.photo_id).standard_price
    end
    total_cents.to_f / 100
  end

  def status
    Status.find(status_id).name
  end
end
