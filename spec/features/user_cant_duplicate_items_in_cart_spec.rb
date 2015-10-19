require "rails_helper"

RSpec.describe "Adding photos to cart: ", type: :feature do
  fixtures :users
  fixtures :stores
  fixtures :photos

  it "can't add the same photo twice" do
    visit photos_path

    2.times do
      first(:link, "Add to Cart").click
    end

    expect(current_path).to eq photos_path
    expect(page).to have_content "already in your cart"
    expect(page).to_not have_content "Successfully added"
  end

end
