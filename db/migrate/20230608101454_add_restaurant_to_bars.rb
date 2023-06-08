class AddRestaurantToBars < ActiveRecord::Migration[7.0]
  def change
    add_column :bars, :restaurant, :boolean, default: false
  end
end
