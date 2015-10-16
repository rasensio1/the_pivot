require "rails_helper"

RSpec.describe "a guest", type: :feature do
  fixtures :stores
  fixtures :users

  it "can visit a store from the correct url" do
    alon = User.find_by(name: "Alon Example")
    store = Store.create(name: "alonstore", tagline: "my store", user_id: alon.id)
    photo = Photo.create(title: "AlonPhoto", description: "yeah", standard_price: 100, store_id: store.id)
    sign_in(alon)

    visit "/alonstore/photos"

    expect(page).to have_content("AlonPhoto")
    expect(page).to_not have_content("Example Title")
  end

end
