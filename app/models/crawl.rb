class Crawl < ApplicationRecord
  belongs_to :user
  has_many :crawlbars
  has_many :bars, through: :crawlbars
  has_many :reviews
  has_one :shared_withs

  validates :crawl_name, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validates :public, inclusion: { in: [true, false] }

  
end
