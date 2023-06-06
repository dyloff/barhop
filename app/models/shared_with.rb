class SharedWith < ApplicationRecord
  belongs_to :crawl
  has_many :users

  # validates :crawl_id, presence: true
  # validates :user_id, presence: true
end
