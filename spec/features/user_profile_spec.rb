require "rails_helper"

RSpec.describe "User profile page: ", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :photos
  fixtures :statuses
  fixtures :orders
  fixtures :order_items

  let!(:order)      {Order.first}
  let!(:user)       {order.user}
  let!(:photo)      {order.order_items.first.photo}

  context "User is not signed in",:order => :defined do
    it "cannot visit the profile page" do
      visit root_path
      expect(page).to_not have_link("Profile")
      visit profile_path

      expect(current_path).to eq("/404")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "User is signed in" do
    before do
      sign_in(user)
      visit root_path
    end

    context "visits the Profile page" do
      before {click_link "Profile"}

      it "can see past orders" do
        expect(current_path).to eq(profile_path)

        within("#order-history") do
          expect(page).to have_content(order.created_at.strftime("%m/%d/%Y"))
          within("#order-number-#{order.id}") {expect(page).to have_link(order.id, order)}
          within("#order-image-count-#{order.id}") {expect(page).to have_content(order.order_items.count)}
          expect(page).to have_content(order.total.to_f / 100)
        end
      end

      context "goes to the single order page" do
        before do
          within("#order-number-#{order.id}") do
            click_link "#{order.id}"
          end
        end

        it "sees the order number" do
          expect(current_path).to eq(order_path(order))
          within(".page-title") do
            expect(page).to have_content "Order Number: #{order.id}"
          end
        end

        it "sees a summary with date" do
          within("#order_summary") do
            expect(page).to have_content("Date: #{order.created_at.strftime("%m/%d/%Y")}")
          end
        end

        it "sees an order item's details" do
          within("#photo-#{photo.id}") do
            expect(page).to have_content(photo.title)
            expect(page).to have_content(photo.shortened_description)
            expect(page).to have_content(photo.standard_price.to_f / 100)
          end
        end

        it "sees the order total" do
          within("#total") do
            expect(page).to have_content("$#{order.total.to_f / 100}")
          end
        end

        it "can go to a photo's detail page" do
          within("#photo-#{photo.id}"){click_link("#{photo.title}")}
          expect(current_path).to eq(store_photo_path(photo.store.slug, photo))
        end

      end
    end
  end
end
