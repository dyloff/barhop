class Follow < ApplicationRecord
  # belongs_to :user

  belongs_to :follower, foreign_key: 'follower_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'

  # validates :follower_id, presence: true
  # validates :following_id, presence: true
end
