require "rails_helper"

RSpec.describe "the user profile page", type: :feature do
  fixtures :photos
  fixtures :stores
  fixtures :order_items
  fixtures :orders
  fixtures :users

  context "a logged in user" do
    let!(:user) {User.first }

    before do
      sign_in(user)
      click_link "Profile"
    end

    it "has a title" do
      expect(page).to have_content "#{user.name}'s Profile"
    end

    it "has titles" do
      within(".profile") do
        expect(page).to have_content "Name"
      end
    end

    it "displays account information" do
        expect(page).to have_content "#{user.name}"
        expect(page).to have_link "Edit Profile"
    end

    context "a logged in user can edit account information" do
      it "can edit information" do
        click_link "Edit Profile"
        expect(current_path).to eq profile_edit_path

        fill_in "Name", with: "Mia"
        fill_in "Password", with: "password"
        click_button "Update Info"

        expect(current_path).to eq profile_path(user)
        expect(page).to have_content "Mia"
      end

      it "is told to entder a password" do
        click_link "Edit Profile"
        expect(current_path).to eq profile_edit_path

        fill_in "Name", with: "Mia"
        click_button "Update Info"

        expect(current_path).to eq profile_path(user)
        expect(page).to have_content "Password - Can't be blank"
      end
    end

    xit 'can download mutiple photos at once' do
      user1 = User.first
      sign_in(user1)

      first(:checkbox, "my-check").set(true)

      click_on "Download Selected"
      expect(page.response_headers['Content-Type']).to eq('text/csv')
    end
  end
end
