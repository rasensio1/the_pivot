require "rails_helper"

RSpec.describe "the photos view", type: :feature do

  let(:user1) {User.create(name: "User1",
                            email: "user1@gmail.com",
                            password: "password",
                            password_confirmation: "password")}

  let(:user2) {User.create(name: "User2",
                            email: "user2@gmail.com",
                            password: "password",
                            password_confirmation: "password")}

  let(:store1) {Store.create(name: "Vernice Huel's Photo Depot",
                              tagline: "Better than those other Photo Depots",
                              user_id: 1)}

  let(:store2) {Store.create(name: "Jacques Stehr's Photo Depot",
                              tagline: "Better than those other Photo Depots",
                              user_id: 2)}

  let(:photo1) {Photo.create(title: "Example Title 1",
                           description: "Fairly long and very expressive title that makes you really think about your place in life 1",
                           standard_price: 99,
                           commercial_price: 9099,
                           image_url: "http://mowalon.com/images/photos_ready/001.jpg",
                           store_id: 1)}

  let(:photo2) {Photo.create(title: "Example Title 2",
                            description: "Fairly long and very expressive title that makes you really think about your place in life 2",
                            standard_price: 399,
                            commercial_price: 10599,
                            image_url: "http://mowalon.com/images/photos_ready/002.jpg",
                            store_id: 2)}

  context "a user visits the all-photos page" do

    it "displays all items" do
      visit photos_path

      expect(page).to have_content photo1.title
      expect(page).to have_content photo2.title
    end

  end
end
