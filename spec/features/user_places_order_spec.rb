require "rails_helper"

RSpec.describe "User with a filled cart",:order => :defined, type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :photos

  let!(:user) { User.first }
  let!(:photo) { Photo.first }

  before do
    visit photos_path
    first(:button, "Add to Cart").click
  end

  context "who has an account" do
    context "and is not signed in" do
      context "and checks out" do

        before do
          visit cart_path
          click_link "Checkout"
        end

        it "is required to login" do
          expect(current_path).to eq login_path
          expect(page).to have_content(
                            "Please sign in to complete your order.")

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
          @previous_order_count = user.orders.count
          click_link "Checkout"
        end

        it "goes to the user profile page" do
          expect(current_path).to eq profile_path
        end

        it "is given a confirmation message" do
          expect(page).to have_content "Your order is complete"
        end

        it "can see the order in Order History" do
          expect(user.orders.count).to eq(@previous_order_count + 1)
          within("#page-title") do
            expect(page).to have_content "#{user.name}'s Profile"
          end

          within("#order-history") do
            expect(page).to have_content(Time.now.utc.strftime("%m/%d/%Y"))
            expect(page).to have_link(user.orders.last.id, user.orders.last)
          end
        end

        it "has an empty cart" do
          visit cart_path

          within("#total") do
            expect(page).to have_content("Total: $0.00")
          end
        end

      end
    end
  end
end
