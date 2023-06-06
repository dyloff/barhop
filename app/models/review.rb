class Review < ApplicationRecord
  belongs_to :crawl
  belongs_to :user

  validates :crawl_id, presence: true
  validates :user_id, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :comment, presence: true
end
