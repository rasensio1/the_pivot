class Category < ActiveRecord::Base
  has_many :photos, through: :photo_categories
  has_many :photo_categories
  validate :check_for_spaces, :check_for_special_characters
  validates :name, presence: true, uniqueness: true

  before_save :capitalize_name

  def self.label(id)
    id == "0" ? "All Photos" : "Category: " + find(id).name
  end

  def to_param
    name
  end

  def check_for_spaces
    if name.to_s.include?(" ")
      errors.add(:invalid, "cannot have spaces")
    end
  end

  def check_for_special_characters
    if name.to_s.match(/[^a-zA-Z0-9]+/)
      errors.add(:alphanumeric, "cannot have special characters")
    end
  end

  def capitalize_name
    name.capitalize!
  end
end
