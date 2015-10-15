require 'rails_helper'

RSpec.describe Photo, type: :model do
  fixtures :photos

    let(:photo) { Photo.first }

  it "is invalid without a title" do
    photo.update(title: nil)

    expect(photo).to_not be_valid
  end
  it "is invalid without a description" do
    photo.update(description: nil)

    expect(photo).to_not be_valid
  end
  it "is invalid without a standard price" do
    photo.update(standard_price: nil)

    expect(photo).to_not be_valid
  end
  it "is invalid without a store id" do
    photo.update(store_id: nil)

    expect(photo).to_not be_valid
  end
end
