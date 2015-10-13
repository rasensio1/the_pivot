require "rails_helper"

RSpec.describe "a user can create a store", type: :feature do
  let(:user) {User.create(username: "Example User",
                          password: "password",
                          password_confirmation: "password")}

  before do
    sign_in(user)
  end

  context "when signed in" do

    it "can create a store" do
      expect(current_path).to eq(profile_path)
      click_link "Create Store"
      expect(current_path).to eq(new_store_path)
      fill_in("name", with: "Example Store")
      fill_in("tagline", with: "Example Tagline")
      click_button "Create Store"
      expect(current_path).to eq(store_admin_path)
      expect(page).to have_content("Example Store")
      expect(page).to have_content("Example Tagline")
      expect(flash[:success]).to be_present
    end

  end
end
