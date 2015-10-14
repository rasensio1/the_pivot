require "rails_helper"

RSpec.describe "a user with a non empty cart", type: :feature do
  let!(:user) { Fabricate(:user) }
  let!(:photo) { Fabricate(:photo) }

  before do
    visit root_path 

    within(".popular-photographs") do
      click_button "Add to Cart" 
    end
  end

  context "who has an account" do
    context "and is not signed in" do
      context "and checks out" do

        before do
          visit cart_path
          click_link "Check Out"
        end

        it "is required to login" do
          expect(current_path).to eq login_path

          expect(page).to have_content(
            "Sign In to complete your order, Dinners almost ready!")

          within(".login-form") do
            expect(page).to have_button "Sign In"
          end
        end
      end
    end

    context "and is signed in" do
      before do
        sign_in(user)
      end

      context "and checks out" do
        before do
          visit cart_path
          click_link "Check Out"
        end

        it "go to the orders page" do
          expect(current_path).to eq orders_path
        end

        it "sees order confirmation message" do
          expect(page).to have_content "Order placed! Dinners on the way!"
        end

        it "sees order" do
          within(".page-title") do
            expect(page).to have_content "#{user.name}'s Orders"
          end

          within(".orders") do
            expect(page).to have_content "Order Number"
            expect(page).to have_content "1"
            expect(page).to have_content "Total"
            expect(page).to have_content (item.price * 3).to_s
          end
        end

        it "sees no items in cart" do
          visit cart_path

          within(".total") do
            expect(page).to have_content("Total")
            expect(page).to have_content("0")
          end
        end

      end
    end
  end
end
