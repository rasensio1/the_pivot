class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  validates :username, presence: true, uniqueness: true
  validates :password, :street_name, :zipcode, :phone_number, presence: true

  enum role: %w(default admin)
end
