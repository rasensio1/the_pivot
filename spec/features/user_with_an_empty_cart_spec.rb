require "rails_helper"

RSpec.describe "user with an empty cart", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :photos

  let!(:user) { User.first }
  let!(:photo) { Photo.first }


  context "visits cart path" do
    before do
      visit cart_path
    end

    context "and is not logged in" do
      it "does not see checkout button" do
        expect(page).to have_link("Keep Shopping")
        expect(page).to_not have_link("Checkout")
      end
    end

    context "and is logged in" do
      before do
        sign_in(user)
        visit cart_path
      end

      it "does not see checkout button" do
        expect(page).to have_link("Keep Shopping")
        expect(page).to_not have_link("Checkout")
      end
    end
  end
end
