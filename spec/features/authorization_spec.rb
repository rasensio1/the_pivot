require "rails_helper"
RSpec.describe "Authorization: " do
  fixtures :users
  fixtures :stores
  fixtures :photos

  let!(:admin) { User.find_by(name: "admin") }
  let!(:store) { admin.store }
  let!(:photo) { admin.store.photos.first }

  context "not logged in" do

    it "cant create a shop" do
      visit new_store_path
      expect(page).to have_content("Not Authorized")
    end

    it "cant view shop admin page" do
      visit admin_store_path(store)
      expect(page).to have_content("Not Authorized")
    end

    xit "cant add shop photo" do
      visit new_store_photo_path(store)
      expect(page).to have_content("Not Authorized")
    end

    xit "cant edit shop photo" do
      visit edit_store_photo_path(store)
      expect(page).to have_content("Not Authorized")
    end
  end
end
