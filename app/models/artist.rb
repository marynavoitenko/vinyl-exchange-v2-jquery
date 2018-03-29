class Artist < ApplicationRecord
  has_many :vinyls

  validates :name, presence: true
  validates :name, uniqueness: true
end
