require "rails_helper"

RSpec.describe "a guest", type: :feature do
  fixtures :stores
  fixtures :users
  fixtures :photos
  fixtures :categories

  context "can visit a store" do
    before do
      category = Category.first
      alon = User.find_by(name: "Alon Example")
      store = Store.create(name: "alonstore", tagline: "my store", user_id: alon.id)
      photo = Photo.update(Photo.first.id, title: "AlonPhoto", description: "yeah", standard_price: 100, store_id: store.id, category_id: category.id)
      Photo.update(Photo.second.id, title: "Not here", description: "yeah", standard_price: 100, store_id: store.id, category_id: Category.last.id)
    end

    let(:store) { Store.find_by(name: "alonstore") }
    let(:category) { Category.first }

    it "from the correct url" do
      visit store_photos_path(store.slug) 

      expect(page).to have_content("AlonPhoto")
      expect(page).to_not have_content("Example Title")
    end

    it "and stort by category" do
      visit store_photos_path(store.slug) 
      click_link category.name

      expect(page).to have_content("AlonPhoto")
      expect(page).to_not have_content("Not here")
    end
  end 
end
