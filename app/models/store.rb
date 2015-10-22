class Store < ActiveRecord::Base
  before_save :set_slug
  after_create :create_store_admin

  validates :name, :tagline, presence: true

  belongs_to :user
  has_many :users, through: :store_admins
  has_many :store_admins

  has_many :photos

  def category_photos(cat_id)
    if cat_id == "0"
      photos.active.all
    else
      Category.find(cat_id).photos.active.where(store_id: self.id)
    end
  end

  def collage_sample
    photos.active.sample(4)
  end

  def watermark_accessor
    photo = Photo.find_by(id: watermark_id)
    photo.file.file.public_id if photo
  end

  def sales_quantity
    photos.reduce(0) {|sum, photo| sum += photo.sales_quantity}
  end

  def sales_total
    photos.reduce(0) {|sum, photo| sum += photo.sales_total}
  end

  private
    def set_slug
      self.slug = name.parameterize
    end

    def create_store_admin
      StoreAdmin.create(user_id: user.id, store_id: id)
    end

end
