class CreateCrawlbars < ActiveRecord::Migration[7.0]
  def change
    create_table :crawlbars do |t|
      t.references :bar, null: false, foreign_key: true
      t.references :crawl, null: false, foreign_key: true

      t.timestamps
    end
  end
end
