require "rails_helper"
RSpec.describe "Authorization: " do
  fixtures :users
  fixtures :stores
  fixtures :photos

  let!(:admin) { User.find_by(name: "admin") }
  let!(:store) { admin.store }
  let!(:photo) { admin.store.photos.first }
  let!(:other_store) { Store.second }

  context "not logged in" do

    it "cant create a shop" do
      visit new_store_path
      expect(page).to have_content("Not Authorized")
    end

    it "cant view shop admin page" do
      visit admin_store_path(store)
      expect(page).to have_content("Not Authorized")
    end

    it "cant add shop photo" do
      visit new_store_photo_path(store.slug)
      expect(page).to have_content("Not Authorized")
    end

    it "cant edit shop photo" do
      visit edit_store_photo_path(store.slug, photo)
      expect(page).to have_content("Not Authorized")
    end
  end

  context "after logging in" do
    it "cant edit someone elses shop" do
      sign_in(admin)

      visit admin_store_path(other_store.slug)
      expect(page).to have_content("Not Authorized")
    end

    it "cant add photo for another shop" do
      visit new_store_photo_path(other_store.slug)
      expect(page).to have_content("Not Authorized")
    end

    it "cant edit photo for another shop" do
      visit edit_store_photo_path(other_store.slug, other_store.photos.first)
      expect(page).to have_content("Not Authorized")
    end
  end
end
