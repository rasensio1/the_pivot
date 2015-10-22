require 'rails_helper'

RSpec.describe PhotoCreator, type: :model do
  fixtures :photos
  fixtures :stores

    let(:photo) { Photo.first }
    let(:store) { Store.first }

  it "can create a watermark photo" do
    params = {:photo => {}} 
    params[:photo][:store_id] = store.id
    params[:photo][:file] = "hello"

    PhotoCreator.watermark_photo(params).save(validate: false)
    photo = Photo.last
    photo.update_column(:file, 'hei')

    expect(store.photos.last.file.filename).to eq('hei')
  end
end
