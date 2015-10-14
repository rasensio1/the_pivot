require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:user) { Fabricate(:user) }
  let!(:photo) { Fabricate(:photo) }
  let!(:status) { Status.create(name: "ordered") }
  let!(:order) { Order.create(user_id: user.id, status_id: status.id) }
  let!(:order_item) { OrderItem.create(order_id: order.id, photo_id: photo.id, quantity: 3) }

  context "a valid order" do
    it "has associated order items" do
      expect(order.customer_name).to eq "Jason"
    end

    it "has a status" do
      expect(order.status).to eq "Ordered"
    end

    it "has a total" do
      expect(order.total).to eq(photo.standard_price * 3)
    end
  end
end
