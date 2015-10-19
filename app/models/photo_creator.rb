class PhotoCreator

  def self.photo(photo_params)
    Photo.new(photo_attributes)
  end

  def photo_attributes(all_params)
      { title: all_params[:title],
      description: all_params[:title],
      standard_price: all_params[:title],
      commercial_price: all_params[:title],
      file: all_params[:title],
      created_at: all_params[:title],
      updated_at: all_params[:title],
      store_id: all_params[:title], }
  end

  def self.create_relations
    Category.create
  end

end
