class Genre < ApplicationRecord
  has_many :vinyl_genres
  has_many :vinyls, through: :vinyl_genres
end
