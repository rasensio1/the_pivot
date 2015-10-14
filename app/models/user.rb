class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_one :store
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true

  enum role: %w(default admin)
end
