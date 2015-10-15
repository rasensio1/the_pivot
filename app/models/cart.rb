class Cart
  attr_accessor :data
  def initialize(data)
    @data = data || Hash.new
  end

  def photos
    data.map do |photo_id, quantity|
      photo = Photo.find(photo_id)
      CartItem.new(photo, quantity)
    end
  end

  def add_item(item)
    data[item.id.to_s] = 1 if data[item.id.to_s].nil?
  end

  def remove_from_cart(item)
    data.delete(item.id.to_s)
  end

  def total
    data.reduce(0) do |total, (id, quantity)|
      total += Photo.find(id).standard_price
    end
  end

  def empty
    @data = Hash.new
  end
end
