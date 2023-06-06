class Favourite < ApplicationRecord
  belongs_to :bar
  belongs_to :user

  validates :bar_id, presence: true
  validates :user_id, presence: true

end
