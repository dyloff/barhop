class CreateBars < ActiveRecord::Migration[7.0]
  def change
    create_table :bars do |t|
      t.string :name
      t.string :location
      t.float :longitude
      t.float :latitude
      t.string :price_range
      t.float :rating
      t.text :description

      t.timestamps
    end
  end
end
