require "rails_helper"

RSpec.describe "the cart", type: :model do
  fixtures :photos

  it "exists" do
    expect(Cart).to be
  end

  context "photos method" do
    let(:photo1) {Photo.first}
    let(:photo2) {Photo.second}

    it "returns an array of cart items" do
      cart_items = {photo1.id => 1, photo2.id => 1}
      cart = Cart.new(cart_items)

      expect(cart.photos).to be_a_kind_of Array
      expect(cart.photos.first).to be_a_kind_of CartItem
      expect(cart.photos.second).to be_a_kind_of CartItem
    end
  end

  context "data method" do
    let(:photo) {Photo.first}
    let(:id) {photo.id.to_s}

    it "returns a hash with the photo id and a quantity of 1" do
      input_data = {id => 1}
      cart = Cart.new(input_data)
      expect(cart.data).to eq({id => 1})
    end
  end

  context "add_item method" do
    let(:photo) {Photo.first}
    let(:id) {photo.id.to_s}
    let(:cart) {Cart.new(nil)}

    context "when cart is empty" do
      it "updates the cart data" do
        expect(cart.data).to eq({})
        cart.add_item(photo)
        expect(cart.data).to eq({id => 1})
      end
    end

    context "when the photo being added is already in the cart" do
      it "does not update the cart" do
        cart.add_item(photo)
        expect(cart.data).to eq({id => 1})
        cart.add_item(photo)
        expect(cart.data).to eq({id => 1})
      end
    end

  end
end
