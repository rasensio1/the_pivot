require 'rails_helper'

RSpec.describe Store, type: :model do
  fixtures :users
  fixtures :photos
  let!(:photo) {Photo.find(1)}
  let!(:store) {Store.create(name: "Test Store",
                              tagline: "Test Tagline",
                              user_id: 1,
                              slug: "test-store",
                              watermark_id: nil)}

  it "is invalid without a name" do
    store.update(name: nil)
    expect(store).to be_invalid
  end

  it "is invalid without a tagline" do
    store.update(tagline: nil)
    expect(store).to be_invalid
  end

  context "with no watermark id" do
    it "gets nil from watermark_accessor" do
      expect(store.watermark_id).to be_nil
      expect(store.watermark_accessor).to be_nil
    end
  end

  context "with a watermark id" do
    before do
      photo.update_column(:file, "image/upload/v1445401814/photos_ready_watermark_200.png")
      store.update(watermark_id: 1)
    end

    it "can retrieve the watermark photo's public_id value" do
      expect(photo.file.filename).to eq("v1445401814/photos_ready_watermark_200.png")
      expect(store.watermark_id).to eq(1)
      expect(store.watermark_accessor).to eq("photos_ready_watermark_200")
    end
  end
end
