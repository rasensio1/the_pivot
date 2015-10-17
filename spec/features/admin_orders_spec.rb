require "rails_helper"

RSpec.describe "an admin" do
  fixtures :users
  fixtures :stores
  fixtures :photos
  fixtures :orders
  fixtures :order_items
  fixtures :statuses

  let!(:store_admin) { User.find_by(name: "admin") }
  let!(:other_store) { Store.find_by(name: "Alons Store")
  }
  let!(:order1) { store_admin.orders.first }
  let!(:order2) { store_admin.orders.last }
  let!(:admin_order_item_1) { order2.order_items.first }
  let!(:admin_order_item_2) { order2.order_items.last }

  context "visits profile" do
    before(:each) do
      sign_in(store_admin)
      visit(profile_path(store_admin))
    end

    it "can see all orders" do
      find("h2", :text => "Order History")

      within("#order-history") do
        find("th", text: "Date")
        find("th", text: "Order #")
        find("th", text: "Images Ordered")
        find("th", text: "Total")

        find("td", text: order1.id)
        find("td", text: "$23.00")
        first("td", text: order1.order_items.count)
        find("td", text: order2.id)
        find("td", text: "170.75")
      end

    end

    it "can view order details" do
      within("#order-show-#{order2.id}") do
        click_link("View")
      end

      expect(current_path).to eq("/orders/#{order2.id}")
      expect(page).to have_content("Order Number: #{order2.id}")
      expect(page).to have_content("Total: $170.75")

      find_link(admin_order_item_1.photo.title).visible?
      expect(page).to have_content(admin_order_item_1.photo.description)
      expect(page).to have_content("$87.34")

      find_link(admin_order_item_2.photo.title).visible?
      expect(page).to have_content(admin_order_item_2.photo.description)
      expect(page).to have_content("$83.41")
    end
  end
end
