require "rails_helper"

RSpec.describe "a guest", type: :feature do
  fixtures :stores
  fixtures :users
  fixtures :photos

  it "can visit a store from the correct url" do
    alon = User.find_by(name: "Alon Example")
    store = Store.create(name: "alonstore", tagline: "my store", user_id: alon.id)
    photo = Photo.update(Photo.first.id, title: "AlonPhoto", description: "yeah", standard_price: 100, store_id: store.id)

    sign_in(User.first)

    visit store_photos_path(store.slug) 
    save_and_open_page

    expect(page).to have_content("AlonPhoto")
    expect(page).to_not have_content("Example Title")
  end

end
