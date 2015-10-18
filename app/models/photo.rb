class Photo < ActiveRecord::Base
  belongs_to :store

  mount_uploader :file, PhotoUploader

  validates :title, :description, :standard_price, :store_id,  presence: true 
  validates :standard_price, :commercial_price, numericality: { greater_than: 0, message: "must contain only integers and be greater than 0" } 

  def shortened_description
    description.length > 60 ? (description[0..60] + "...") : description
  end

  def file_location
    file_url ? file_url : image_url
  end

  def self.active
    Photo.where(active: true)
  end

  def category
    Category.find(category_id) rescue Category.new(name: "")
  end

end
