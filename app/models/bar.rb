class Bar < ApplicationRecord
  has_many :crawlbars
  has_many :favourites

  price = %w[£ ££ £££ ££££]

  validates :name, presence: true
  validates :location, presence: true
  validates :price_range, presence: true, inclusion: { in: price }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :description, presence: true
  # validates :image_url, presence: true
end
