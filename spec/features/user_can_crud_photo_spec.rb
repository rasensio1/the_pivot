require "rails_helper"

RSpec.describe "photos" do

  context "store admin" do
    let!(:category) { Category.create(name: "Landscape")}
    let!(:store_admin) { Fabricate(:user, role: 1) }
    let!(:store) { Fabricate(:store, user_id: store_admin.id) }
    let!(:photo) { Fabricate(:photo, store_id: store.id, category_id: category.id ) }

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
      select("Landscape", :from => 'photo[category_id]')

      click_button("Create Photo")

      expect(current_path).to eq(admin_store_path(store.slug))
      expect(page).to have_content("#{photo.title} photo has been added!")
      expect(page).to have_content(photo.title)
      expect(page).to have_content(photo.description)
      expect(page).to have_content(photo.category.name)
    end

    it "renders messages when creating with invaid params" do
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

      click_on "Edit"

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
      click_on "Delete"

      expect(current_path).to eq(admin_store_path(store_admin.store.slug))

      visit current_path
      expect(page).to_not have_content(photo.title)
      expect(page).to_not have_content(photo.description)
    end

  end
end
