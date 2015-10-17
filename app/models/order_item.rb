class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :photo

  def title 
    photo.title
  end

  def description
    photo.description
  end

  def price
    photo.standard_price
  end

  def subtotal
    photo.standard_price * quantity
  end
end
