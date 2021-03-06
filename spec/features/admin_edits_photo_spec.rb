require "rails_helper"

RSpec.describe "a store admin" do
  fixtures :users
  fixtures :stores
  fixtures :store_admin
  fixtures :photos

  let!(:admin) { User.find_by(name: "admin") }
  let!(:store) { admin.stores.first }
  let!(:photo) { store.photos.first }


  context "visits photo management page" do
    before do
      store.photos.last.delete
      sign_in(admin)
      visit admin_store_path(store.slug)
    end

    context "clicks the Edit link" do
      before do
        click_link "Edit"
      end

      it "sees the edit form for that photo" do
        expect(current_path).to eq(edit_store_photo_path(store.slug, photo))

        expect(page).to have_content("Edit Photo")
        expect(page).to have_selector("input[value='#{photo.title}']")
        expect(page).to have_selector("input[value='#{photo.title}']")
        expect(page).to have_selector("input[value='#{photo.description}']")
        expect(page).to have_selector("input[value='$23.00']")
      end

      it "shows store admin page after submit" do
        fill_in "Title", with: "New Title"
        click_button "Submit"

        expect(current_path).to eq(admin_store_path(store.slug))
      end

      it "updates the title" do
        fill_in "Title", with: "New Title"
        click_button "Submit"

        within("#active-photos") do
          expect(page).to have_content("New Title")
        end
      end

      it "updates the description" do
        fill_in "Description", with: "New Description"
        click_button "Submit"

        within("#active-photos") do
          expect(page).to have_content("New Description")
        end
      end

      it "updates the standard price" do
        fill_in "Standard price", with: 51
        click_button "Submit"

        within("#active-photos") do
          expect(page).to have_content("$51.00")
        end
      end

      context "with invalid input params" do
        it "is redirected to the form with error messages" do
          fill_in "Standard price", with: "Hello"
          click_button "Submit"

          expect(current_path).to eq(edit_store_photo_path(store.slug, photo))
          expect(page).to have_content("Standard price - Must contain")
        end
      end
    end

    it "can go to the show paage" do
      click_link photo.title

      expect(page).to have_content(photo.title)
      expect(current_path).to eq(store_photo_path(store.slug, photo))
    end
  end
end
