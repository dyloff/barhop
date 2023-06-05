class Review < ApplicationRecord
  belongs_to :crawl
  belongs_to :user
end
