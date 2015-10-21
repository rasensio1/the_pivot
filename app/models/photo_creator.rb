class PhotoCreator

  def self.photo(photo_params)
    Photo.new(photo_params)
  end

  def self.create_relations(photo, all_params)
    all_params[:photo][:category_ids].each do |id|
      PhotoCategory.create(photo_id: photo.id, category_id: id)
    end
  end

  def self.edit_relationships(photo, all_params)
    photo.photo_categories.delete
    all_params[:photo][:category_ids].each do |id|
      PhotoCategory.create(photo_id: photo.id, category_id: id)
    end
  end
end
