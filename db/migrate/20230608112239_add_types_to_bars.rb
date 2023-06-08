class AddTypesToBars < ActiveRecord::Migration[7.0]
  def change
    add_column :bars, :types, :text, array: true, default: []
  end
end
