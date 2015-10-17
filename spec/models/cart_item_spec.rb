require "rails_helper"

RSpec.describe "the cart item", type: :model do
  fixtures :photos
  let(:photo) {Photo.first}

  it "returns the title of the photo" do
    cart_item = CartItem.new(photo)
    expect(cart_item.title).to eq "Example Title 1"
  end

  it "returns the quantity for a photo" do
    cart_item = CartItem.new(photo, 1)
    expect(cart_item.quantity).to eq 1
  end
end
