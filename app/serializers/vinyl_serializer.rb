class VinylSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :inventory, :for_sale
  belongs_to :artist
  has_many :genres
end
