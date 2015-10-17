require "rails_helper"

RSpec.describe OrderItem, type: :model do
  fixtures :photos
  fixtures :order_items
  let(:order_item) {OrderItem.first}

  context "a valid order item" do
    it "has an order_id" do
      expect(order_item.order_id).to be_a_kind_of Integer
    end

    it "photo_id" do
      expect(order_item.photo_id).to be_a_kind_of Integer
    end

    it "a quantity" do
      expect(order_item.quantity).to be_a_kind_of Integer
    end

  end
end
