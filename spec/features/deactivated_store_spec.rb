require "rails_helper"

RSpec.describe "a store admin", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :store_admin
  fixtures :categories
  fixtures :photos

  let!(:store_admin) { User.find_by(email: "admin@admin.com") }
  let!(:store) { store_admin.store }
  let!(:photo) { store.photos.first }

  before do
    store.update_attribute(:active, false)
    sign_in(store_admin)
  end

  context "for a deactivated store" do
    before do
      visit(admin_store_path(store.slug))
    end

    it "sees a deactivation message" do
      expect(page).to have_content("This store is not currently activated. No photos will be available for purchase!")
    end

    it "can still add photos" do
      click_on "Add a photo"
      fill_in("photo[title]", with: photo.title)
      fill_in("photo[description]", with: photo.description)
      fill_in("photo[standard_price]", with: photo.standard_price)
      page.attach_file("photo[file]", Rails.root + "spec/fixtures/test_photo_1.jpg")
      check "Lifestyle"

      click_button("Create Photo")

      expect(page).to have_content("#{photo.title}' has been added!")
      expect(page).to have_content(photo.title)
    end

    it "can add an admin to the store" do
      fill_in("user[email]", with: store_admin.email)
      click_on "Add New Admin"

      expect(page).to have_content(store_admin.name)
      expect(page).to have_content(store_admin.email)
    end

    it "can edit a stores info" do
      fill_in "Name", with: "Mia"
      fill_in "Tagline", with: "Yep"
      click_button "Update Info"

      expect(page).to have_content "Mia"
      expect(page).to have_content "Yep"
    end

    it "can edit a photo" do
      within "#active-photos" do
        first(:link, "Edit").click
      end

      fill_in("photo[title]", with: "Another title")
      fill_in("photo[description]", with: "Woohoo")

      click_on "Submit"
      expect(page).to have_content("Another title")
      expect(page).to have_content("Woohoo")
    end
  end

end
