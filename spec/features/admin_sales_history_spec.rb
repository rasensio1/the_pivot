require "rails_helper"

RSpec.describe "an admin" do
  fixtures :users
  fixtures :stores
  fixtures :store_admin
  fixtures :photos
  fixtures :orders
  fixtures :order_items

  let!(:admin) {User.find_by(name: "admin")}
  let!(:store) {Store.find_by(user_id: admin.id)}
  let!(:photo) {store.photos.first}


  context "logs in and visits the dashboard" do
    before do
      sign_in(admin)
      click_link "Dashboard"
    end

    it "can access the Sales History page" do
      expect(page).to have_link("Sales History")
      click_link "Sales History"
      expect(current_path).to eq(admin_store_sales_path(store.slug))
    end

    context "visits the Sales History page" do
      before do
        click_link "Sales History"
      end

      it "has a header with title, sales total, and button back to the dashboard" do
        expect(page).to have_content("#{store.name} Sales")
        expect(page).to have_link("Back to Dashboard")
        expect(page).to have_content("Sales to Date: $#{(store.sales_total.to_f / 100)}")
      end

      it "has all the desired table data" do
        within("#title-#{photo.id}") do
          expect(page).to have_link(photo.title)
        end
        within("#categories-#{photo.id}") do
          expect(page).to have_content(photo.categories.first)
        end
        within("#quantity-#{photo.id}") do
          expect(page).to have_content(photo.sales_quantity)
        end
        within("#revenue-#{photo.id}") do
          expect(page).to have_content("$#{photo.sales_total.to_f / 100}")
        end
      end

      it "has total quantity and revenue at the bottom of the page" do
        within("#footer") do
          expect(page).to have_content(store.sales_quantity)
          expect(page).to have_content("$#{store.sales_total.to_f / 100}")
        end
      end

    end

  end
end
