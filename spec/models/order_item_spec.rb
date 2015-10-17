require "rails_helper"

RSpec.describe OrderItem, type: :model do
  fixtures(:order_items)
  fixtures(:photos)

  let(:order_item) { OrderItem.first}

  context "a valid order item" do

    it "has a title" do
      expect(order_item.title).to eq  order_item.photo.title
    end

    it "has a description" do
      expect(order_item.description).to eq order_item.photo.description
    end

    it "has a price" do
      expect(order_item.price).to eq order_item.photo.standard_price
    end

  end
end
