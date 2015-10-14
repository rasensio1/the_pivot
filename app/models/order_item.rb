class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :photo

  def image_url
    current_item.image_url
  end

  def name
    current_item.title
  end

  def description
    current_item.description
  end

  def price
    current_item.standard_price
  end

  def category_id
    current_item.category_id
  end

  def subtotal
    current_item.standard_price * quantity
  end

  private

  def current_item
    Photo.find(photo_id)
  end
end
