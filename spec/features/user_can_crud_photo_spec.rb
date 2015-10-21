require "rails_helper"

RSpec.describe "photos" do

  context "store admin" do
    fixtures :users
    fixtures :store_admin
    fixtures :stores
    fixtures :photos
    fixtures :categories

    let!(:store_admin) {User.find_by(name: "admin")}
    let!(:store) {store_admin.store}
    let!(:photo) {store.photos.first}
    let!(:category1) {Category.first}
    let!(:category2) {Category.second}
    let!(:category3) {Category.third}

    before do
      sign_in(store_admin)
      click_link "Dashboard"
    end

    it "can add a photo" do
      click_on "Add a photo"
      fill_in("photo[title]", with: photo.title)
      fill_in("photo[description]", with: photo.description)
      fill_in("photo[standard_price]", with: photo.standard_price)
      fill_in("photo[commercial_price]", with: photo.commercial_price)
      page.attach_file("photo[file]", Rails.root + "spec/fixtures/test_photo_1.jpg")

      check "Lifestyle"
      check "Architecture"
      check "Landscape"

      click_button("Create Photo")

      expect(current_path).to eq(admin_store_path(store.slug))
      expect(page).to have_content("#{photo.title} photo has been added!")
      expect(page).to have_content(photo.title)
      expect(page).to have_content(photo.description)
      expect(page).to have_content(category1.name)
      expect(page).to have_content(category2.name)
      expect(page).to have_content(category3.name)
    end

    it "gets error messages when using invalid params" do
      visit new_store_photo_path(store.slug)

      fill_in("photo[title]", with: "")
      fill_in("photo[description]", with: "")
      fill_in("photo[standard_price]", with: "hi")

      click_button("Create Photo")

      expect(current_path).to eq(new_store_photo_path(store.slug))
      expect(page).to have_content("Title - Can't be blank")
      expect(page).to have_content("Description - Can't be blank")
      expect(page).to have_content("Standard price - Must contain")
    end

    it "can edit a photo" do
      visit admin_store_path(store_admin.store.slug)

      first(:link, "Edit").click

      expect(current_path).to eq(edit_store_photo_path(photo.store.slug, photo))

      fill_in("photo[title]", with: "Another title")
      fill_in("photo[description]", with: "Woohoo")

      click_on "Submit"
      expect(current_path).to eq(admin_store_path(photo.store.slug))
      expect(page).to have_content("Another title")
      expect(page).to have_content("Woohoo")
    end

    it "can delete a photo" do
      visit admin_store_path(store_admin.store.slug)
      starting_photo_count = store.photos.active.count
      first(:link, "Delete").click


      expect(current_path).to eq(admin_store_path(store_admin.store.slug))
      expect(store.photos.active.count).to eq(starting_photo_count - 1)
      expect(page).to have_content(photo.title + " photo has been removed")

      within("#active-photos") do
        expect(page).to_not have_content(photo.title)
        expect(page).to_not have_content(photo.description)
      end
    end

  end
end
