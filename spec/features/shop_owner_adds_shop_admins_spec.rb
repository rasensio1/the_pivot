require "rails_helper"

RSpec.describe "an admin on their dashboards" do

  it "can add other admins for her shop" do
    admin = User.create(name: "Admin", email: "admin@yeah.com", password: "password")
    ryan = User.create(name: "Regular Ryan", email: "ryan@yeah.com", password: "password")
    store = Store.create(name: "The Store", tagline: "For everyone", user_id: admin.id)
    sign_in(admin)

    visit edit_admin_store_path(store)

    fill_in("user[name]", with: "Regular Ryan")
    fill_in("user[email]", with: "ryan@yeah.com")
    click_on "Add Admin"

    expect(page).to have_content("Regular Ryan")
    expect(page).to have_content("ryan@yeah.com")

    click_on "Sign Out"

    sign_in(ryan)

    expect(page).to have_content("Admin for")
    expect(page).to have_content("The Store")
  end
end
