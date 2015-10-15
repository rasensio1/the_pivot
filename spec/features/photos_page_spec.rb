require "rails_helper"

RSpec.describe "the photos view", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :photos

  let(:photo1) {Photo.find_by(title: "Title 1")}
  let(:photo2) {Photo.find_by(title: "Title 2")}
  let(:photo3) {Photo.create(title: "OH YEAH", description: "totally not here", status: 1)}

  context "a user visits the all-photos page" do

    it "displays all photos" do
      visit photos_path
      expect(page).to have_content photo1.title
      expect(page).to have_content photo2.title
    end

    it "doesn't display inactive photos" do
      visit photos_path
      expect(page).to_not have_content photo3.title
      expect(page).to_not have_content photo3.description
    end

  end
end
