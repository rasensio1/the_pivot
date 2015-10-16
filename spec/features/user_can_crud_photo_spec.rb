require "rails_helper"

RSpec.describe "photos" do

  context "store admin" do
    let!(:store_admin) { Fabricate(:user, role: 1) }
    let!(:store) { Fabricate(:store, user_id: store_admin.id) }
    let!(:photo) { Fabricate(:photo, store_id: store.id) }

    before do
      sign_in(store_admin)
    end

    it "can add a photo" do
      click_on "My Store"

      click_on "Add a photo"

      fill_in("photo[title]", with: photo.title)
      fill_in("photo[description]", with: photo.description)
      fill_in("photo[standard_price]", with: photo.standard_price)
      fill_in("photo[commercial_price]", with: photo.commercial_price)

      click_button("Create Photo")

      expect(current_path).to eq(edit_admin_store_path(store))
      expect(page).to have_content("#{photo.title} photo has been added!")
      expect(page).to have_content(photo.title)
      expect(page).to have_content(photo.description)
    end

    it "can edit a photo" do
      visit edit_admin_store_path(store_admin.store.id)

      click_on "Edit"

      expect(current_path).to eq(edit_store_photo_path(photo.store, photo))

      fill_in("photo[title]", with: "Another title")
      fill_in("photo[description]", with: "Woohoo")

      click_on "Submit"
      expect(current_path).to eq(edit_admin_store_path(photo))
      expect(page).to have_content("Another title")
      expect(page).to have_content("Woohoo")
    end
    
    it "can delete a photo" do
      visit edit_admin_store_path(store_admin.store.id)

      click_on "Delete"

      expect(current_path).to eq(edit_admin_store_path(photo))

      visit current_path
      expect(page).to_not have_content(photo.title)
      expect(page).to_not have_content(photo.description)
    end

  end
end
