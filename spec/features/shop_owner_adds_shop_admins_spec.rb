require "rails_helper"

RSpec.describe "an admin on their dashboards" do

  let(:admin) { User.create(name: "Admin", email: "admin@yeah.com", password: "password") }
  let(:store) { Store.create(name: "The Store", tagline: "For everyone", user_id: admin.id) }
  let(:ryan) { User.create(name: "Regular Ryan", email: "ryan@yeah.com", password: "password") }

  it "can add other admins for her shop" do
    StoreAdmin.create(user_id: admin.id, store_id: store.id)
    ryan = User.create(name: "Regular Ryan", email: "ryan@yeah.com", password: "password")
    sign_in(admin)

    visit admin_store_path(store.slug)

    fill_in("user[email]", with: "ryan@yeah.com")
    click_on "Add New Admin"

    expect(page).to have_content("Regular Ryan")
    expect(page).to have_content("ryan@yeah.com")

    click_on "Sign Out"

    sign_in(ryan)

    expect(page).to have_content("Admin for")
    expect(page).to have_content("The Store")
  end

  it "can not add an admin that is not regestered" do

    ryan = User.create(name: "Regular Ryan", email: "ryan@yeah.com", password: "password")
    sign_in(admin)

    visit admin_store_path(store.slug)

    fill_in("user[email]", with: "ryan@yeah.com")
    click_on "Add New Admin"

    expect(page).to have_content("Regular Ryan")
    expect(page).to have_content("ryan@yeah.com")

    fill_in("user[email]", with: "ryan@yeah.com")
    click_on "Add New Admin"

    expect(page).to have_content("Cannot add duplicate admins!")
  end

  it "can not add an admin multiple times" do
    unregistered_user = "unregestered@user.boo"
    sign_in(admin)

    visit admin_store_path(store.slug)

    fill_in("user[email]", with: unregistered_user)
    click_on "Add New Admin"

    expect(current_path).to eq(admin_store_path(store.slug))

    expect(page).to have_content("Sorry, but #{unregistered_user} is not a Photo's Ready user.")
  end

  context "the new admin" do
    before do
      StoreAdmin.create(user_id: ryan.id, store_id: store.id)
    end

    it "can visit the shop" do
      sign_in(ryan)

      click_on "The Store"

      expect(current_path).to eq(admin_store_path(store.slug))
      expect(page).to have_content("For everyone")
      expect(page).to_not have_content("Add an Admin")
    end

    it "can add a photo" do
      sign_in(ryan)

      click_on "The Store"
      click_on "Add a photo"

      expect(current_path).to eq(new_store_photo_path(store.slug))
      expect(page).to have_content("Add a Photo")
    end
  end
end
