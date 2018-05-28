class Vinyl < ApplicationRecord
  belongs_to :artist, required: false
  has_many :vinyl_genres
  has_many :genres, through: :vinyl_genres
  has_many :line_items
  has_many :carts, through: :line_items
  belongs_to :user, required: false

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :price, presence: true
  validates :inventory, presence: true

  def self.for_sale
    Vinyl.where("for_sale = ? AND inventory > ?", true, 0)
  end

  def self.for_sale_exclude_current_user(user)
    Vinyl.where.not("user_id = ?", user.id) & Vinyl.for_sale
  end

  def self.my_vinyls(user)
    Vinyl.where("user_id = ?", user.id)
  end

  def for_sale_display
    self.for_sale ? "yes" : "no"
  end

  def in_stock
    self.inventory > 0
  end

  def next
    next_vinyls = Vinyl.where("id > ?", id)
    next_vinyls.empty? ? Vinyl.first : next_vinyls.first
  end

  def genres_attributes=(genres_attributes)
    genres_attributes.values.each do |genre_attributes|
      genre = Genre.find_or_create_by(genre_attributes)
      self.vinyl_genres.build(genre: genre)
    end
  end

  def artist_attributes=(artist_attributes)
    if artist_id
      artist = Artist.find(artist_id)
    else
      artist = Artist.find_or_create_by(artist_attributes)
    end  
    self.artist = artist
  end

end
