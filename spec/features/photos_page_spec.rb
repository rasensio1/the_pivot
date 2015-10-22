require "rails_helper"

RSpec.describe "the photos view", type: :feature do
  fixtures :users
  fixtures :photos
  fixtures :stores

  let!(:store) { User.find_by(email: "admin@admin.com").store }
  let!(:deactivated_store_photo) { store.photos.first }
  let!(:photo1) { Photo.first }
  let!(:photo2) { Photo.second }
  let!(:photo3) { Photo.third }
  let!(:deactivated_store_photo) { Photo.fourth }

  context "a user visits the all-photos page" do
    before do
      visit root_path
      click_link "All Photos"
    end


    it "and sees all available photos" do
      expect(page).to have_content photo1.title
      expect(page).to have_content photo2.title
      expect(page).to have_content photo3.title
    end

    context "and does not see photos" do
      before do
        store.update_attribute(:active, false)
        deactivated_store_photo.update_attribute(:title, "unique title")
        store.photos << deactivated_store_photo

        visit root_path
        click_link "All Photos"
      end

      it "from deactivated stores" do
        expect(page).not_to have_content(deactivated_store_photo.title)
      end
    end
  end

  context "a photo is set to inactive" do
    before do
      photo2.update(title: "Inactive Photo", active: false)
      visit root_path
      click_link "All Photos"
    end

    it "doesn't display inactive photos" do
      expect(photo2.title).to eq("Inactive Photo")
      expect(page).to have_content photo1.title
      expect(page).to_not have_content photo2.title
      expect(page).to have_content photo3.title
    end
  end


  context "a user views categories" do
    let!(:cat) { Category.create(name: "Landscape") }

    before do
      visit root_path
    end

    it "displays all Landscape photo" do
      PhotoCategory.create(photo_id: photo1.id, category_id: cat.id)
      PhotoCategory.create(photo_id: photo2.id, category_id: cat.id)

      click_link "Landscape"

      expect(page).to have_content("Category: Landscape")
      expect(page).to have_content photo1.title
      expect(page).to have_content photo2.title
      expect(page).to_not have_content photo3.title
    end
  end
end
