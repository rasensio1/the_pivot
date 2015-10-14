class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.integer :standard_price
      t.integer :commercial_price
      t.string :image_url

      t.timestamps null: false
    end
  end
end
