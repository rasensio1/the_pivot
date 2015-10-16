class Store < ActiveRecord::Base
  before_validation :set_slug
  belongs_to :user

  has_many :photos

  private
    def set_slug
      self.slug = name.parameterize
    end
end
