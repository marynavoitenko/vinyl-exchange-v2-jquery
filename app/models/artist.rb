class Artist < ApplicationRecord
  has_many :vinyls

  validates :name, uniqueness: true
end
