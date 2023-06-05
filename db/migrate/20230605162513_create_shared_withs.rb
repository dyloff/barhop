class CreateSharedWiths < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_withs do |t|
      t.references :crawl, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
