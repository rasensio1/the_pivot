class Store < ActiveRecord::Base
  before_validation :set_slug
  belongs_to :user
  has_many :users, through: :store_admins
  has_many :store_admins

  has_many :photos

  private
    def set_slug
      self.slug = name.parameterize
    end
end
