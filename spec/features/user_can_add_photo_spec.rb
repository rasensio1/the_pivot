require "rails_helper"

RSpec.describe "photos" do

  context "store admin" do
    let!(:store_admin) { Fabricate(:user, role: 1) }
    let!(:store) { Fabricate(:store, user_id: store_admin.id) }

    before do
      sign_in(store_admin)
    end

    it "can add a photo" do
      title = "the title"
      description = "the description"
      standard_price = 10
      commercial_price = 5
      image_url = "the image url"

      visit new_admin_photo_path

      fill_in("photo[title]", with: title)
      fill_in("photo[description]", with: description)
      fill_in("photo[standard_price]", with: standard_price)
      fill_in("photo[commercial_price]", with: commercial_price)
      fill_in("photo[image_url]", with: image_url)

      click_button("Create Photo")

      expect(current_path).to eq(edit_admin_store_path(store))

      expect(page).to have_content("#{title} photo has been added!")
    end

    xit "add expects for the photo showing up on the store admin page when its done" do
      expect(true)
    end

  end
end
