class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_one :store
  has_many :store_admins
  has_many :stores, through: :store_admins

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def photos
    photo_ids = OrderItem.where(order: orders).pluck(:photo_id)
    Photo.where(id: photo_ids)
  end

  def store_owner?
    !self.store.nil?
  end

end
