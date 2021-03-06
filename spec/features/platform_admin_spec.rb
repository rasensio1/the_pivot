require "rails_helper"

RSpec.describe "a platform admin", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :store_admin
  fixtures :categories
  fixtures :photos

  let!(:platform_admin) { User.find_by(email: "platform_admin@admin.com") }
  let!(:store_admin) { User.find_by(email: "admin@admin.com") }
  let!(:new_admin) { User.find_by(email: "jason@example.ninja") }
  let!(:store) { store_admin.store }
  let!(:photo) { store.photos.first }
  let!(:category1) { Category.first }
  let!(:category2) { Category.second }
  let!(:category3) { Category.third }

  it "dashboard cannot be accessed by store_admin" do
    sign_in(new_admin)

    visit(god_dashboard_path)

    expect(page).to have_content("Not Authorized")
  end

  it "goes to dashboard after login" do
    sign_in(platform_admin)

    expect(current_path).to eq(god_dashboard_path)
    expect(page).to have_content("You are all Powerful!")

    expect(page).to have_link(store.name)
  end

  context "who is logged in" do
    before do
      sign_in(platform_admin)
      store.photos.last.delete
    end

    it "has their dashboard link in the header" do
      within(".navbar") do
        expect(page).to have_link("Dashboard")
        click_on "Dashboard"
      end

      expect(current_path).to eq(god_dashboard_path)
    end

    it "does not have a profile link in header" do
      within(".navbar") do
        expect(page).not_to have_link("Profile")
      end
    end

    xit "can deactivate a store" do
      within("##{store.slug}") do
        expect(find_field("store[active]")).to be_checked
        uncheck("store[active]")
        click_on "Update"
      end

      expect(current_path).to eq(god_dashboard_path)
      expect(page).to have_content("#{store.name} has been updated!")
      within("##{store.slug}") do
        expect(find_field("store[active]")).not_to be_checked
      end
    end

    xit "can activate a store" do
      store.update_attribute(:active, false)
      visit god_dashboard_path

      within("##{store.slug}") do
        expect(find_field("store[active]")).not_to be_checked
        check("store[active]")
        click_on "Update"
      end

      expect(current_path).to eq(god_dashboard_path)
      expect(page).to have_content("#{store.name} has been updated!")
      within("##{store.slug}") do
        expect(find_field("store[active]")).to be_checked
      end
    end

    context "and visits a stores dashboard" do
      before do
        click_link store.name
        expect(current_path).to eq(admin_store_path(store.slug))
      end

      it "can add a photo to any store" do
        click_on "Add a photo"
        fill_in("photo[title]", with: photo.title)
        fill_in("photo[description]", with: photo.description)
        fill_in("photo[standard_price]", with: photo.standard_price)
        page.attach_file("photo[file]", Rails.root + "spec/fixtures/test_photo_1.jpg")

        check "Lifestyle"
        check "Architecture"
        check "Landscape"

        click_button("Create Photo")

        expect(current_path).to eq(admin_store_path(store.slug))
        expect(page).to have_content("#{photo.title}' has been added!")
        expect(page).to have_content(photo.title)
      end

      it "can edit a photo for any store" do
        within "#active-photos" do
          first(:link, "Edit").click
        end

        expect(current_path).to eq(edit_store_photo_path(store.slug, photo))

        fill_in("photo[title]", with: "Another title")
        fill_in("photo[description]", with: "Woohoo")

        click_on "Submit"
        expect(current_path).to eq(admin_store_path(store.slug))
        expect(page).to have_content("Another title")
        expect(page).to have_content("Woohoo")
      end

      it "can delete a photo for any store" do
        within "#active-photos" do
          first(:link, "Delete").click
        end

        expect(current_path).to eq(admin_store_path(store.slug))
        expect(page).to have_content(photo.title + "' has been removed")

        within("#active-photos") do
          expect(page).to_not have_content(photo.title)
          expect(page).to_not have_content(photo.description)
        end
      end

      it "can add an admin to any store" do
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

    end

  end
end
