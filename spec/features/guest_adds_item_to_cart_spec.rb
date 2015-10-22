require "rails_helper"

RSpec.describe "the cart", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :photos
  fixtures :statuses
  fixtures :orders
  fixtures :order_items

  let!(:user) {User.first}

  context "a guest" do

    it "can add photos to the cart from root" do
      visit cart_path
      expect(page).to_not have_content "Example Title"

      visit root_path

      within(".popular-photographs") do
        first(:link, "Add to Cart").click
      end

      expect(current_path).to eq root_path
      expect(page).to have_content "Successfully added"

      click_link "Cart"

      expect(current_path).to eq cart_path
      expect(page).to have_content "Example Title"
      expect(page).to have_content "Example Description"
    end

    it "can login and items persist in the cart" do
      visit cart_path
      expect(page).to_not have_content "Example Title"

      visit root_path
      within(".popular-photographs") do
        first(:link, "Add to Cart").click
      end
      sign_in(user)
      visit root_path
      click_link "Cart"

      expect(page).to have_content "Example Title"
      expect(page).to have_content "Example Description"
    end

    it "can remove items from the cart" do
      visit cart_path
      expect(page).to_not have_content "Example Title"

      visit root_path
      within(".popular-photographs") do
        first(:link, "Add to Cart").click
      end
      sign_in(user)
      visit root_path
      click_link "Cart"

      click_link "Remove"

      expect(page).to have_content "Successfully removed"
      expect(page).to_not have_content "Example Description"
    end

  end

  context "a logged in user" do

    it "can add items to the cart" do
      visit cart_path
      expect(page).to_not have_content "Example Title"

      sign_in(user)
      visit root_path

      within(".popular-photographs") do
        first(:link, "Add to Cart").click
      end

      click_link "Cart"

      expect(page).to have_content "Example Title"
      expect(page).to have_content "Example Description"
    end
  end
end
