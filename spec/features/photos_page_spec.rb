require "rails_helper"

RSpec.describe "the photos view", type: :feature do

  let!(:photo) { Fabricate(:photo) }
  let!(:photo2) {Photo.create(title: "Lame", description: "bad bad bad", status: 1)}

  context "a user visits the all-photos page" do

    it "displays all photos" do
      visit photos_path
      expect(page).to have_content photo.title
    end

    it "doesn't display inactive photos" do
      visit photos_path

      expect(page).to_not have_content photo2.title
      expect(page).to_not have_content photo2.description
    end

  end
end
