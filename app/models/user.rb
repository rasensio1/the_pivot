class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_one :store

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true

  enum role: %w(default admin)

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def photos
    photo_ids = OrderItem.where(order: orders).pluck(:photo_id)
    Photo.where(id: photo_ids)
  end

end
