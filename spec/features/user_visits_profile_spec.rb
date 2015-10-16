require "rails_helper"

RSpec.describe "a user", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :photos
  fixtures :statuses
  fixtures :orders
  fixtures :order_items

  let!(:user)   {User.first}
  let!(:order)  {user.orders.first}
  let!(:photo)  {user.photos.first}
  let!(:status) {Status.first}

  context "is logged in" do
    it "can see past orders" do
      sign_in(user)
      visit root_path
      click_link "Profile"
      expect(current_path).to eq(profile_path)

      within("#order-history") do
        expect(page).to have_content(order.created_at.strftime("%m/%d/%Y"))
        within("#order-number-#{order.id}") {expect(page).to have_link(order.id, order)}
        within("#order-image-count-#{order.id}") {expect(page).to have_content(order.order_items.count)}
        expect(page).to have_content(order.total.to_f / 100)
      end
    end
  end

  context "is not logged in" do

    it "cannot visit the profile page" do
      visit root_path
      expect(page).to_not have_link("Profile")
      visit profile_path

      expect(current_path).to eq("/404")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
