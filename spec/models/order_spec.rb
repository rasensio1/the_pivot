require 'rails_helper'

RSpec.describe Order, type: :model do
  fixtures :users
  fixtures :stores
  fixtures :photos
  fixtures :statuses
  fixtures :orders
  fixtures :order_items

  let!(:order) {Order.first}
  # let!(:user)  {order.user}
  # let!(:photo) {order.order_items.first.photo}

  context "a valid order" do
    it "has associated order_items" do
      expect(order.order_items.count).to eq(2)
      expect(order.order_items.first).to be_a_kind_of OrderItem
    end

    it "has a customer_name" do
      expect(order.customer_name).to eq("User 1")
    end

    it "has a status" do
      expect(order.status).to eq("Completed")
    end

    it "has a total" do
      expect(order.total).to be_a_kind_of Integer
    end
  end
end
