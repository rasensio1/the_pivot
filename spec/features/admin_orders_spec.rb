require "rails_helper"

RSpec.describe "an admin" do

  let!(:store_admin) { User.create(name: "admin", email: "admin@admin.com", password: "password", role: 1) }
  let!(:store) {
    Store.create(
      name:    "#{store_admin.name} store",
      tagline: "#{store_admin.name} store tagline",
      user_id: store_admin.id
    )
  }

  let!(:photo) {
    Photo.create(
      title:            "#{store_admin.name} photo title",
      description:      "A not very long descrioptoin",
      standard_price:   333,
      commercial_price: 4444,
      store_id:         store_admin.id,
      file:             File.open(File.join(Rails.root, '/spec/fixtures/test_photo_1.jpg'))
    )
  }


  # let!(:ordered_status) { Status.create(name: "Ordered") }
  # let!(:paid_status) { Status.create(name: "Paid") }
  # let!(:cancelled_status) { Status.create(name: "Cancelled") }
  let!(:completed_status) { Status.create(name: "Completed") }

  let!(:order) {
    Order.create(user_id: store_admin.id, status_id: completed_status.id)
  }


  let!(:order_item) {
    OrderItem.create(order_id: order.id, quantity: 1, photo_id: photo.id)
  }

  context "visits admin dashboard" do
    before(:each) do
      sign_in(store_admin)

      visit edit_admin_store_path(store)
      click_link "View All Orders"
    end


    it "can see all orders" do
      expect(page).to have_content("Ordered")
      expect(page).to have_content("Paid")
      expect(page).to have_content("Cancelled")
      expect(page).to have_content("Completed")

      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
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
