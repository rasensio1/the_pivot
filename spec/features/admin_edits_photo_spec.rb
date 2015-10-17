require "rails_helper"

RSpec.describe "a store admin" do
  fixtures :users
  fixtures :stores
  # fixtures :photos


  let!(:admin) { User.find_by(name: "admin") }
  # let!(:photo) { admin.store.photos.first }


  context "visits photo management page" do
    before do
      # sign_in(admin)
      # expect(current_path).to be(profile_path)
      # visit edit_admin_store_path
    end

    context "clicks the Edit link" do
      before do
        # click_link "Edit"
      end

      it "a test" do
        expect(true).to be(false)
      end

      xit "shows the edit page for that item" do
        expect(current_path).to eq("/admin/items/#{item.id}/edit")
      end

      xit "updates the name" do
        fill_in "Name", with: "New Name"
        click_button "Update Meal"

        expect(current_path).to eq(admin_items_path)
        expect(page).to have_content("New Name")
      end

      xit "updates the description" do
        fill_in "Description", with: "New Description"
        click_button "Update Meal"

        expect(page).to have_content("New Description")
      end

      xit "updates the price " do
        fill_in "Price", with: 5
        click_button "Update Meal"

        expect(page).to have_content(5)
      end

      xit "updates the image_url" do
        fill_in "Image url", with: "new_image_url"
        click_button "Update Meal"

        expect(page).to have_css("img[src*='images/new_image_url']")
      end

      xit "updates the status" do
        select "Retired", from: "item[status]"
        click_button "Update Meal"

        expect(page).to have_content("retired")
      end
    end
  end
end
