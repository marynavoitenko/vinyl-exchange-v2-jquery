class Vinyl < ApplicationRecord
  belongs_to :artist
  has_many :vinyl_genres
  has_many :genres, through: :vinyl_genres
  has_many :line_items
  has_many :carts, through: :line_items
  belongs_to :user

  validates :title, presence: true
  validates :price, presence: true

  def self.for_sale
    Vinyl.where("for_sale = ?", true)
  end

  def self.my_vinyl
    Vinyl.where("user_id = ?", current_user.id)
  end

end
