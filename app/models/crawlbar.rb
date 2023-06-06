class Crawlbar < ApplicationRecord
  belongs_to :bar
  belongs_to :crawl

  validates :bar_id, presence: true
  validates :crawl_id, presence: true
end
