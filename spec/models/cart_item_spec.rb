require "rails_helper"

RSpec.describe "the cart item", type: :model do
  fixtures(:photos)
  let(:photo) { Photo.first }

  it "returns the name of the item" do
    cart_item = CartItem.new(photo)
    expect(cart_item.title).to eq photo.title 
  end

  it "returns the quantity for a specific item" do
    cart_item = CartItem.new(photo, 2)
    expect(cart_item.quantity).to eq 2
  end
end
