class CartItem < SimpleDelegator
  attr_reader :quantity, :photo

  def initialize(photo, quantity = 0)
    super(photo)
    @photo = photo
    @quantity = quantity
  end

  def subtotal
    @photo.standard_price * quantity
  end
end
