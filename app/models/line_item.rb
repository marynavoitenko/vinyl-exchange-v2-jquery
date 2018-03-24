class LineItem < ApplicationRecord
  belongs_to :vinyl
  belongs_to :cart
end
