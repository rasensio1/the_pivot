class Store < ActiveRecord::Base
  before_validation :set_slug
  after_create :create_store_admin

  belongs_to :user
  has_many :users, through: :store_admins
  has_many :store_admins

  has_many :photos

  private
    def set_slug
      self.slug = name.parameterize
    end

    def create_store_admin
      StoreAdmin.create(user_id: user.id, store_id: id)
    end
end
