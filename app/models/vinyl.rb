class Vinyl < ApplicationRecord
  belongs_to :artist
  has_many :vinyl_genres
  has_many :genres, through: :vinyl_genres
  has_many :line_items
  has_many :carts, through: :line_items
  belongs_to :user

end
