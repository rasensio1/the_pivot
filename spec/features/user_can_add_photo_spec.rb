require "rails_helper"

RSpec.describe "photos" do

  context "store admin" do
    let!(:store_admin) { Fabricate(:user, role: 1) }

    before do
      sign_in(store_admin)
    end

    it "can add photo" do
      title = "the title"

      visit new_admin_photo_path

      fill_in("photo[title]", with: title)

      click_button("Create Photo")

      expect(current_path).to eq(profile_path)

      save_and_open_page

      expect(page).to have_content("#{title} photo has been added!")


      # t.string   "description"
      # t.integer  "standard_price"
      # t.integer  "commercial_price"
      # t.string   "image_url"
      # t.datetime "created_at",       null: false
      # t.datetime "updated_at",       null: false
      # t.integer  "store_id"


    end

  end
end
