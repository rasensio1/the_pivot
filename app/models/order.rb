class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, autosave: true
  has_many :items, through: :order_items

  def customer_name
    User.find(user_id).name
  end

  def total
    photo = Photo.find(order_item.photo_id)
    order_items.inject(0) {|total, order_item| total += photo.standard_price}
  end

  def status
    Status.find(status_id).name
  end
end
