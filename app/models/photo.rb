class Photo < ActiveRecord::Base
  belongs_to :store

  mount_uploader :file, PhotoUploader

  def shortened_description
    description.length > 60 ? (description[0..60] + "...") : description
  end

  def file_location
    file_url ? file_url : image_url
  end

end
