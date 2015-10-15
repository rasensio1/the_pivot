require "rails_helper"

RSpec.describe "a user", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :photos
  fixtures :statuses
  fixtures :orders
  fixtures :order_items

  let!(:order)  {Order.first}
  let!(:user)   {order.user}
  let!(:photo)  {Photo.first}
  let!(:status) {Status.first}

  context "is logged in" do

    it "can see past orders" do

      visit root_path

      click_link "Profile"

      within(".orders") do
        expect(page).to have_content("Order Number")
        expect(page).to have_content("Total")
        expect(page).to have_content("Order Updated Date")
        expect(page).to have_link(photo.id)
        expect(page).to have_link(photo.id)
        expect(page).to have_content((photo.standard_price * 3).to_s)
        expect(page).to have_content(photo.standard_price)
      end
    end

    xit "can see the date the order status changed" do
      todays_date = Order.create(user_id: user.id, status_id: status.id)
                      .updated_at
                      .strftime("%A, %b %d %Y %l:%M %p")

      order.update_attribute("status_id", 2)

      within(".orders") do
        expect(page).to have_content(todays_date)
      end
    end
  end

  context "is not logged in" do
    xit "cannot visit the profile page" do
      expect(page).to have_content("Sorry but Dinner is not here!")
      expect(page).to have_link("But I know where to get it!")
    end
  end
end
