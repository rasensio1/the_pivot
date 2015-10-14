require "rails_helper"

RSpec.describe "the cart quantity", type: :feature do
    let!(:user) { Fabricate(:user) }
    let!(:photo) { Fabricate(:photo) }
    let!(:category) { Category.create(name: "Lunch") }

    before do
      sign_in(user)
      visit root_path 
    end

  context "a user with photos in the cart" do
    it "adds photos to the cart" do

    2.times do
      within(".popular-photographs") do
        click_button "Add to Cart" 
      end
    end

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content photo.title
        expect(page).to have_content "2"
        click_button "+"
      end

      expect(page).to have_content "3"
    end

    it "decreases quantity of photos from the cart" do

      2.times do
        within(".popular-photographs") do
          click_button "Add to Cart" 
        end
      end

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content photo.title 
        expect(page).to have_content "2"
        click_button "-"
      end

      expect(page).to have_content "1"
    end

    it "displays total cost" do
      2.times do
        within(".popular-photographs") do
          click_button "Add to Cart" 
        end
      end
      click_link "Cart"

      within(".total") do
        expect(page).to have_content((photo.standard_price * 2).to_s)
      end
    end

    it "displays the subtotal" do
      4.times do
        within(".popular-photographs") do
          click_button "Add to Cart" 
        end
      end
      click_link "Cart"

      within(".subtotal") do
        expect(page).to have_content((photo.standard_price * 4).to_s)
      end
    end

    it "removes photos from the cart" do
      within(".popular-photographs") do
        click_button "Add to Cart" 
      end
      click_link "Cart"

      click_link "Remove"
      expect(page).to have_content "Successfully removed #{photo.title} from your cart."

      within(".table-striped") do
        expect(page).to_not have_content photo.title
      end

      click_link photo.title

      expect(current_path).to eq meal_path(photo)
    end

    it "removes the photo if the quantity is zero" do
        within(".popular-photographs") do
          click_button "Add to Cart" 
        end
      click_link "Cart"

      click_button "-" 

      within(".table-striped") do
        expect(page).to_not have_content photo.title 
      end
    end
  end
end
