require "rails_helper"

RSpec.describe "photos" do
  let!(:user) { User.create(name: "Ryan", email: "ryan@yeah.com", password: "password") }
  let!(:store) { Store.create(name: "ryans Store", tagline: "the best", user_id: user.id) }
  

  context "store admin" do

    before do
      sign_in(user)
    end

    it "can edit store name and tagline" do
      click_on "My Store"

      fill_in("store[name]", with: "Different shop")
      fill_in("store[tagline]", with: "Pretty Good")

      click_button("Update Info")

      expect(current_path).to eq(admin_store_path(store.slug))
      expect(page).to have_content("Different shop")
      expect(page).to have_content("Pretty Good")
    end

  end
end
