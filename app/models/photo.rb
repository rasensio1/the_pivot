class Photo < ActiveRecord::Base
  belongs_to :store

  mount_uploader :file, PhotoUploader

  validates :title, :description, :standard_price, :store_id,  presence: true
  validates :standard_price, :commercial_price, numericality: { greater_than: 0, message: "must contain only integers and be greater than 0" }

  def shortened_description
    description.length > 60 ? (description[0..60] + "...") : description
  end

  def file_location(type = :preview)
    # byebug if self.store.id == 101
    file_url ? file_url : seed_url(type)
  end


  def self.active
    where(active: true)
  end

  def self.cat_filter(id)
    id == "0" ? all : where(category_id: id)
  end

  def category
    Category.find(category_id) rescue Category.new(name: "")
  end

  private

    def seed_url(type)
      type = type.to_s
      file_url ? file_url : seed_path + "#{type}/" + seed_name + "_#{type}.jpg"
    end

    def seed_path
      "http://mowalon.com/images/photos_ready/"
    end
end
