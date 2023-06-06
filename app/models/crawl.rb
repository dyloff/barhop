class Crawl < ApplicationRecord
  belongs_to :user
  has_many :crawlbars
  has_many :reviews
  has_many :shared_withs


  validates :user_id, presence: true
  validates :crawl_name, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validates :public, inclusion: { in: [true, false] }
end
