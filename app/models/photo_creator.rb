class PhotoCreator

  def self.photo(photo_params)
    Photo.new(photo_params)
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
