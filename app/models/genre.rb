class Genre < ApplicationRecord
  has_many :vinyl_genres
  has_many :vinyls, through: :vinyl_genres

  validates :name, presence: true
  validates :name, uniqueness: true
end
