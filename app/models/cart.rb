class Cart < ApplicationRecord
  has_many :line_items
  has_many :vinyls, through: :line_items
  belongs_to :user

  def add_item(item_id)
    line_item = self.line_items.find_by(vinyl_id: item_id)
    if line_item
      line_item.quantity += 1
      line_item.save
    else
      line_item = self.line_items.build(vinyl_id: item_id)
    end
    line_item
  end
end
