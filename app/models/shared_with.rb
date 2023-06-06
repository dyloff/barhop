class SharedWith < ApplicationRecord
  belongs_to :crawl
  belongs_to :user

  validates :crawl_id, presence: true
  validates :user_id, presence: true
end
