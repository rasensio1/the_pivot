require "rails_helper"

RSpec.describe "the user profile page", type: :feature do
  context "a logged in user" do
    let!(:user) { Fabricate(:user) }

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
    end

    xit 'can download mutiple photos at once' do

    end

  end
end
