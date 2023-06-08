class Bar < ApplicationRecord
  has_many :crawlbars
  has_many :bars, through: :crawlbars
  has_many :favourites

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  price = %w[1 2 3 4]

  validates :name, presence: true
  validates :location, presence: true
  validates :price_range, presence: true, inclusion: { in: price }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :description, presence: true
  # validates :image_url, presence: true

  # scope :search_by_address 

end

# scope :filter_by_price, ->(price) { where price: price }
# scope :filter_by_artist, ->(artist) { where artist: artist }
