class VinylSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :inventory, :for_sale
  belongs_to :artist
end
