class Photo < ActiveRecord::Base
  belongs_to :store
  has_many :categories, through: :photo_categories
  has_many :photo_categories

  mount_uploader :file, PhotoUploader

  validates :title, :description, :standard_price, :store_id, :file, presence: true
  validates :standard_price, :commercial_price, numericality: { greater_than: 0, message: "must contain only integers and be greater than 0" }

  def shortened_description
    description.length > 60 ? (description[0..60] + "...") : description
  end

  def self.active
    where(active: true)
  end

  def self.category_photos(cat_id)
    if cat_id == "0"
      active.all
    else
      Category.find(cat_id).photos.active
    end
  end

  def watermark?
    id == store.watermark_id
  end

end
