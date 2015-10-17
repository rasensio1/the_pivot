require "rails_helper"

RSpec.describe "the profile view", type: :feature do
  fixtures :users
  let!(:user) {User.first}

  context "a logged in user" do
    before do
      sign_in(user)
    end

    it "can visit the profile page" do
      expect(page).to have_content "YeeHaw! #{user.name} is signed in!"
      expect(page).to have_link "Profile"

      within(".navbar-nav") do
        click_link "Profile"
      end

      expect(current_path).to eq profile_path
      expect(page).to have_content "#{user.name}'s Profile"
    end
  end

  context "user who's not logged in" do
    it "can't visit the profile page" do
      visit root_path
      expect(page).to_not have_link "Profile"

      visit profile_path
      expect(current_path).to eq "/404"
    end
  end

end
