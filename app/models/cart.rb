class Cart < ApplicationRecord
  has_many :line_items
  has_many :vinyls, through: :line_items
end
