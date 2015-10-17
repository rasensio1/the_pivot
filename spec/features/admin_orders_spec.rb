require "rails_helper"



# An admin user should have a profile link and a dashboard link, make them go rght places and test
# Hardcoded fixture values for money in tests, think of something better maybe
# Add a view button to orders table on profile page


RSpec.describe "an admin" do
  fixtures :users
  fixtures :stores
  fixtures :photos
  fixtures :orders
  fixtures :order_items

  let!(:store_admin) { User.find_by(name: "admin") }
  let!(:order1) { store_admin.orders.first }
  let!(:order2) { store_admin.orders.last }

  context "visits profile" do
    before(:each) do
      sign_in(store_admin)
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
        find("td", text: "$87.34")
      end

    end

    xit "can click a link to view an order" do
      click_link "View"

      expect(current_path).to eq("/orders/#{order.id}")
      expect(page).to have_content("Order Number: #{order.id}")
    end

    xit "can see ordered orders" do
      expect(page).to have_content(ordered_status.name)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    xit "can see paid orders" do
      expect(page).to have_content(paid_status.name)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    xit "can see cancelled orders" do
      expect(page).to have_content(cancelled_status.name)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    xit "can see completed orders" do
      expect(page).to have_content(completed_status.name)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    xit "can see the total number of orders for all types" do
      orders = Order.all

      expect(page).to have_content(orders.count)
    end

    xit "can see the total number of ordered orders" do
      orders = Order.where(status_id: ordered_status.id)

      expect(page).to have_content(orders.count)
    end

    xit "can see the total number of orders for paid orders" do
      orders = Order.where(status_id: paid_status.id)

      expect(page).to have_content(orders.count)
    end

    xit "can see the total number of orders for cancelled orders" do
      orders = Order.where(status_id: cancelled_status.id)

      expect(page).to have_content(orders.count)
    end

    xit "can see the total number of orders for completed orders" do
      orders = Order.where(status_id: completed_status.id)

      expect(page).to have_content(orders.count)
    end

    xit "can change the status for an individual order if the status is paid" do
      order.update_attributes(status_id: paid_status.id)
      click_link "View"

      expect(page).to have_content(paid_status.name)
      select "Completed", from: "order[status]"
      click_button "Update Order Status"
      expect(current_path).to eq(admin_orders_path)
      expect(page).to have_content(completed_status.name)
    end

    xit "can change the status for an individual order if status is ordered" do
      order.update_attributes(status_id: ordered_status.id)
      click_link "View"

      expect(page).to have_content(ordered_status.name)
      select "Paid", from: "order[status]"
      click_button "Update Order Status"
      expect(current_path).to eq(admin_orders_path)
      expect(page).to have_content(paid_status.name)
    end


    xit "updating the status changes the status attribute in the database" do
      order.update_attributes(status_id: ordered_status.id)
      click_link "View"

      select "Paid", from: "order[status]"
      click_button "Update Order Status"


      expect(current_path).to eq(admin_orders_path)
      expect(page).to have_content "Paid Total: 1"
    end
  end
end
