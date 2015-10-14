require "rails_helper"

RSpec.describe "a user who signs up", type: :feature do

  context "correctly" do
    it "is presented with a confirmation and is redirected to profile" do
      visit sign_up_path

      within(".create-user-form") do
        fill_in "Name", with: "ryan"
        fill_in "Password", with: "password"
        fill_in "Email", with: "ryan@yeah.com"
        click_button "Sign Up"
      end

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Ryan")
        expect(page).to have_content("ryan@yeah.com")
    end
  end

  context "incorrectly and is redirected to signup" do
    it "when they dont enter a username" do
      visit sign_up_path

      within(".create-user-form") do
        fill_in "Password", with: "secret"
        click_button "Sign Up"
      end

      expect(current_path).to eq(sign_up_path)
      expect(page).to have_content("Ya screwed something up parter, try again!")
    end

    it "when they dont enter a password" do
      visit sign_up_path

      within(".create-user-form") do
        fill_in "Name", with: "Ruffus"
        click_button "Sign Up"
      end

      expect(current_path).to eq(sign_up_path)
      expect(page).to have_content("Ya screwed something up parter, try again!")
    end
  end
end
