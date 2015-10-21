require "rails_helper"

RSpec.describe "a platform admin", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :store_admin
  fixtures :categories
  fixtures :photos

  let!(:platform_admin) { User.find_by(email: "platform_admin@admin.com") }
  let!(:store_admin) { User.find_by(email: "admin@admin.com") }
  let!(:store) { store_admin.store }
  let!(:photo) { store.photos.first }
  let!(:category1) { Category.first }
  let!(:category2) { Category.second }
  let!(:category3) { Category.third }

  it "goes to dashboard after login" do
    sign_in(platform_admin)

    expect(current_path).to eq(god_dashboard_path)
    expect(page).to have_content("You are all Powerful!")

    expect(page).to have_link(store.name)
  end

  it "has their dashboard link in the header" do
    sign_in(platform_admin)

    within(".navbar") do
      expect(page).to have_link("Dashboard")
      click_on "Dashboard"
    end

    expect(current_path).to eq(god_dashboard_path)
  end

  it "can add a photo to any store" do
    sign_in(platform_admin)

    visit admin_store_path(store.slug)

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
  end

end
