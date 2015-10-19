class PhotoCreator

  def self.photo(photo_params)
    Photo.new(photo_attributes)
  end

  def photo_attributes(all_params)
      { title: all_params[:title],
      description: all_params[:description],
      standard_price: all_params[:standaard_price],
      commercial_price: all_params[:commercial_price],
      file: all_params[:file],
      created_at: all_params[:created_at],
      updated_at: all_params[:updated_at],
      store_id: all_params[:store_id], }
  end

  def self.create_relations(all_params)
    Category.create
  end

end
