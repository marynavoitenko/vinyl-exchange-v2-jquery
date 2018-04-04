class Cart < ApplicationRecord
  has_many :line_items
  has_many :vinyls, through: :line_items
  belongs_to :user

  def add_item(vinyl_id)
    line_item = self.line_items.find_by(vinyl_id: vinyl_id)
    if line_item
      line_item.quantity += 1
    else
      line_item = self.line_items.build(vinyl_id: vinyl_id)
    end
    vinyl = Vinyl.find(vinyl_id)
    vinyl.update_inventory(line_item.quantity) if line_item.vinyl.in_stock
  end


  def total
    total = 0
    self.line_items.each do |line_item|
      vinyl = Vinyl.find(line_item.vinyl_id)
      total += (vinyl.price * line_item.quantity)
    end
    total
  end
end
