class AddPlaceIdToBars < ActiveRecord::Migration[7.0]
  def change
    add_column :bars, :place_id, :string
  end
end
