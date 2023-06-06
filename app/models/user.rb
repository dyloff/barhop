class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reviews
  has_many :crawls
  has_many :favourites
  has_many :shared_withs

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
