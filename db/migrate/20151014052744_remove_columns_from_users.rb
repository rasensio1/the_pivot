class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :zipcode
    remove_column :users, :phone_number
    remove_column :users, :street_name
  end
end
