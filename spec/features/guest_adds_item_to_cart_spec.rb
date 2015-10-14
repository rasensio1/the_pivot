require "rails_helper"

RSpec.describe "the cart", type: :feature do
  context "a user that's not logged in" do
    let!(:item) { Fabricate(:item) }
    let!(:user) { Fabricate(:user) }
    let!(:photo) { Fabricate(:photo) }

    it "can add photos to the cart from root" do
      visit root_path 

      expect(page).to have_content photo.title
      within(".popular-photographs") do
        click_button "Add to Cart" 
      end
      expect(current_path).to eq root_path 

      click_link "Cart"
      expect(current_path).to eq cart_path

      expect(page).to have_content photo.title
      expect(page).to have_content "1"
    end

    it "can login and his/her items persist in the cart" do
      visit root_path 

      within(".popular-photographs") do
        click_button "Add to Cart" 
      end
      expect(current_path).to eq root_path 

      sign_in(user)

      click_link "Cart"

      expect(page).to have_content photo.title
      expect(page).to have_content "1"
    end
  end

  context "a user that's logged in" do
    let!(:photo) { Fabricate(:photo) }
    let!(:user) { Fabricate(:user) }

    it "can add items to the cart" do
      sign_in(user)
      visit root_path 

      2.times do
        within(".popular-photographs") do
          click_button "Add to Cart" 
        end
      end

      click_link "Cart"

      expect(page).to have_content photo.title
      expect(page).to have_content "2"
    end
  end

  context "a user that's logged in" do
    let!(:item) { Fabricate(:item) }
    let!(:user) { Fabricate(:user) }

    xit "can add items to the cart" do
      sign_in(user)
      visit menu_path

      within(".item-info") do
        expect(page).to have_content item.name
        2.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content item.name
        expect(page).to have_content "2"
      end
    end
  end
end
