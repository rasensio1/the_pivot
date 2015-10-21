class PhotoCreator

  def self.photo(photo_params)
    Photo.new(photo_params)
  end

  def self.watermark_photo(params)
    store = params[:photo][:store_id]
    file = params[:photo][:file]
    Photo.new(title: "Store #{store} Watermark #{Time.now.strftime('%s')}",
              description: "Store #{store} Watermark",
              standard_price: 1,
              commercial_price: 1,
              store_id: store,
              file: file,
              active: false)
  end

  def self.create_relations(photo, all_params)
    if all_params[:photo][:watermark]
      old_watermark_id = photo.store.watermark_id
      photo.store.update(watermark_id: photo.id)
      Photo.find(old_watermark_id).destroy if old_watermark_id
    else
      all_params[:photo][:category_ids].each do |id|
        PhotoCategory.create(photo_id: photo.id, category_id: id)
      end
    end
  end
end
