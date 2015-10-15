class Photo < ActiveRecord::Base
  belongs_to :store

  mount_uploader :file, PhotoUploader

  enum status: %w(active inactive)

  def shortened_description
    description.length > 60 ? (description[0..60] + "...") : description
  end

  def file_location
    file_url ? file_url : image_url
  end

  def self.active
    Photo.where(status: 0)
  end

end
