class Vinyl < ApplicationRecord
  belongs_to :artist
  has_many :vinyl_genres
  has_many :genres, through: :vinyl_genres
  has_many :line_items
  has_many :carts, through: :line_items
  belongs_to :user

  validates :title, presence: true
  validates :price, presence: true
  validates :inventory, presence: true  

  def self.for_sale
    Vinyl.where("for_sale = ?", true)
  end

  def self.my_vinyls(user)
    Vinyl.where("user_id = ?", user.id)
  end

end
