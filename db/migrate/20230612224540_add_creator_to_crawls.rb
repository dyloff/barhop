class AddCreatorToCrawls < ActiveRecord::Migration[7.0]
  def change
    add_column :crawls, :creator, :boolean, default: false
  end
end
