class StoreAdmin < ActiveRecord::Base
  belongs_to :user
  belongs_to :store

  validates :user_id, uniqueness: { scope: :store_id,
        message: "Cannot add duplicate Admins!" }
end
