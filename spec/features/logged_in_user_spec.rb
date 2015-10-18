require "rails_helper"

RSpec.describe "profile view", type: :feature do
  fixtures :users
  fixtures :stores

  let!(:user) { User.find_by(email: "jason@example.ninja") }
  let!(:store_admin) { User.find_by(email: "admin@admin.com") }

  context "a logged in user" do
    before do
      sign_in(user)
    end

    it "can visit the profile page" do
      expect(page).to have_content "YeeHaw! #{user.name} is signed in!"
      expect(page).to have_link "Profile"

      expect(current_path).to eq profile_path
      expect(page).to have_content "#{user.name}'s Profile"
    end

    it "does not have a dashboard link" do
      expect(page).to_not have_link("Dashboard")
    end
  end


  context "a user who's not logged in" do
    it "can't visit the profile page" do
      visit root_path
      expect(page).to_not have_link "Profile"
      expect(page).to_not have_link "Dashboard"

      visit profile_path
      expect(current_path).to eq "/404"
    end
  end

  context "a logged in store administrator" do
    before do
      sign_in(store_admin)
    end

    it "has a dashboard link" do
      expect(page).to have_link("Dashboard")
    end
  end

end
