require "rails_helper"

RSpec.describe "an admin on their dashboards" do

  it "can add other admins for her shop" do
    admin = User.create(name: "Admin", email: "admin@yeah.com", password: "password")
    ryan = User.create(name: "Regular Ryan", email: "ryan@yeah.com", password: "password")
    store = Store.create(name: "The Store", tagline: "For everyone", user_id: admin.id)
    StoreAdmin.create(user_id: admin.id, store_id: store.id)
    sign_in(admin)

    visit admin_store_path(store.slug)

    fill_in("user[email]", with: "ryan@yeah.com")
    click_on "Add Admin"

    expect(page).to have_content("Regular Ryan")
    expect(page).to have_content("ryan@yeah.com")

    click_on "Sign Out"

    sign_in(ryan)

    expect(page).to have_content("Admin for")
    expect(page).to have_content("The Store")
  end

  it "and the new admin can visit the shop" do
    admin = User.create(name: "Admin", email: "admin@yeah.com", password: "password")
    ryan = User.create(name: "Regular Ryan", email: "ryan@yeah.com", password: "password")
    store = Store.create(name: "The Store", tagline: "For everyone", user_id: admin.id)
    StoreAdmin.create(user_id: ryan.id, store_id: store.id)

    sign_in(ryan)

    click_on "The Store"

    expect(current_path).to eq(admin_store_path(store.slug))
    expect(page).to have_content("For everyone")
    expect(page).to_not have_content("Add an Admin")

  end
end
