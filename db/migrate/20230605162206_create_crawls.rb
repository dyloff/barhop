class CreateCrawls < ActiveRecord::Migration[7.0]
  def change
    create_table :crawls do |t|
      t.references :user, null: false, foreign_key: true
      t.string :crawl_name
      t.boolean :completed
      t.boolean :public
      t.date :date

      t.timestamps
    end
  end
end
