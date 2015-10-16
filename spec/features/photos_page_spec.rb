require "rails_helper"

RSpec.describe "the photos view", type: :feature do
  fixtures :photos
  fixtures :stores

  let!(:photo1) {Photo.first}
  let!(:photo2) {Photo.second}
  let!(:photo3) {Photo.third}

  context "a user visits the all-photos page" do
    before do
      visit root_path
      click_link "All Photos"
    end

    it "displays all photos" do
      expect(page).to have_content photo1.title
      expect(page).to have_content photo2.title
      expect(page).to have_content photo3.title
    end
  end

  context "a photo is set to inactive" do
    before do
      photo2.update(title: "Inactive Photo", status: 1)
      visit root_path
      click_link "All Photos"
    end

    it "doesn't display inactive photos" do
      expect(photo2.status).to eq("inactive")
      expect(photo2.title).to eq("Inactive Photo")
      expect(page).to have_content photo1.title
      expect(page).to_not have_content photo2.title
      expect(page).to have_content photo3.title
    end
  end
end
